#!/usr/bin/env python3
from time import sleep

def synthesize_text(text, lang, name, speed, ofile):
    """Synthesizes speech from the input string of text."""
    from google.cloud import texttospeech
    client = texttospeech.TextToSpeechClient()

    input_text = texttospeech.types.SynthesisInput(text=text)

    # Note: the voice can also be specified by name.
    # Names of voices can be retrieved with client.list_voices().
    voice = texttospeech.types.VoiceSelectionParams(
        language_code=lang,
        name=name)

    audio_config = texttospeech.types.AudioConfig(
        audio_encoding=texttospeech.enums.AudioEncoding.MP3,
        speaking_rate=speed)

    response = client.synthesize_speech(input_text, voice, audio_config)

    # The response's audio_content is binary.
    with open(ofile, 'wb') as out:
        out.write(response.audio_content)

if __name__ == "__main__":
    import sys
    argv = sys.argv
    if argv[3] == 'e':
        speed=1.0
        lang='en-US'
        #name='en-US-Wavenet-A' # man
        name='en-US-Wavenet-C' # woman
    else:
        speed=1.0
#        speed=1.7
#        speed=2.5
        lang='ja-JP'
        name='ja-JP-Standard-A' # only

    wait=1
    for i in range(1, 10):
        try:
            synthesize_text(open(argv[1],'r').read(), lang, name, speed, argv[2])
            break;
        except Exception as err:
            print(i, ' caught an exception (', err, ')')
            sleep(wait)
            wait *= 2



