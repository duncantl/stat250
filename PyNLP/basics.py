import nltk

sentence = 'Identification and Control for Pattern Steering in Dynamical Networks'
tokens = nltk.word_tokenize(sentence)
pos = nltk.pos_tag(tokens)
pos

