Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C920D591D46
	for <lists+cgroups@lfdr.de>; Sun, 14 Aug 2022 02:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiHNAde (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Aug 2022 20:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiHNAde (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 13 Aug 2022 20:33:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085257697D
        for <cgroups@vger.kernel.org>; Sat, 13 Aug 2022 17:33:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a7so7914277ejp.2
        for <cgroups@vger.kernel.org>; Sat, 13 Aug 2022 17:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=+NyoTrWa+bHRaItdT05SvVLNy2r+kdJC3mJlBlsSK+k=;
        b=RSf/avcMaGTy2UbVL4cEhyWxtuwcXruTbXUMjS6mPBX1Ir2iUtF7GXiAmF/H56F2s0
         ZvyKURdtH+q/U4RLMRKzkYGlwXDbkjl33PRdlZenEbbWz3Ms375UVT60T+GRZME7EmvW
         C4+TpUs9uTQ9Lay9imOlK2xxBZND0YG8mX4JJR5qmHBXikGyp3wHYw/wMLB0rtcmwEen
         XqfoUMMeDjtz2tB5aU/vsbnxBdG9q28xsayLZz3zNWTfV/+KTxK7QVMrHZLFW7EepA2r
         eKeb8nPujP6LDJmgEhj5Uo8Md2csc4judvMW51zHWIV1FSML90ddovEo7LeHHXMUJlHl
         U3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+NyoTrWa+bHRaItdT05SvVLNy2r+kdJC3mJlBlsSK+k=;
        b=etjiBkx0eeMGn42Reuzo2kjwUTkhWao1zUoSNZbzBZzIRDqMUaJ0R7svm5eoFwg9gM
         27y8j9PhYUD7tHUXMcP4r2RmtYXgx3vINRhcpEyaTQZZVDvJdnQz9UjuS3lxEA4ooExU
         hZN83/A/qb+qVcro8kdrLe25jx7Y6UTJFcwflNrZjjddO8zWSAsgxwCLVXUC7BmMOzfR
         Uo4PO86RrBs5BICf3TfHeYBkxYUd+o9dkwsEoIToqrLIRdBK4scVKXtxiX2X7VoMeoqh
         p+c7mNeLi/G6CPYpaoz+uPiMflsPHMCNtG4c1PVgvWSRfJuz+Oogt4sg2AnSrlVgdqRn
         WfFA==
X-Gm-Message-State: ACgBeo02rwA6CmWZIm7Im+8oM5uHfO0QV/6e1RdAhfdvupDvR/8iPKAN
        NW37AotQKbMyM3YA0ZMdJPcv7SvHcyis+yII30M=
X-Google-Smtp-Source: AA6agR49YcWhhJKgQwwfmbjUIH8K/BZhUhY0blhjsSaEiXfb3HFQ09n2vu1Id/aNarA3gd2QPO3f6oxGGbQ5S+sNV/Y=
X-Received: by 2002:a17:906:9bc9:b0:730:6595:dfc8 with SMTP id
 de9-20020a1709069bc900b007306595dfc8mr6304259ejc.286.1660437210598; Sat, 13
 Aug 2022 17:33:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2dd1:0:0:0:0:0 with HTTP; Sat, 13 Aug 2022 17:33:30
 -0700 (PDT)
Reply-To: mrstheresaheidi8@gmail.com
From:   Ms Theresa Heidi <imranemoussa63@gmail.com>
Date:   Sat, 13 Aug 2022 17:33:30 -0700
Message-ID: <CAHSdUJj7wJ2VfR4WQ0YtgRp6t-0kZ+CD+xQZ_J-BN3WH2ozNMQ@mail.gmail.com>
Subject: =?UTF-8?B?R0nDmlAgxJDhu6AgS0jhuqhOIEPhuqRQIQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [imranemoussa63[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [imranemoussa63[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrstheresaheidi8[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

UVVZw4pOIEfDk1AgVOG7qiBUSEnhu4ZOIQ0KDQpYaW4gdnVpIGzDsm5nIMSR4buNYyBr4bu5LCB0
w7RpIGJp4bq/dCDEkcO6bmcgbMOgIGLhu6ljIHRoxrAgbsOgeSBjw7MgdGjhu4MgxJHhur9uIHbh
u5tpIGLhuqFuDQpuaMawIG3hu5l0IMSRaeG7gXUgYuG6pXQgbmfhu50uIFTDtGkgxJHDoyB0w6xt
IHRo4bqleSBsacOqbiBo4buHIHF1YSBlLW1haWwgY+G7p2EgYuG6oW4gdGjDtG5nDQpxdWEgbeG7
mXQgY3Xhu5ljIHTDrG0ga2nhur9tIHJpw6puZyB0xrAgdHJvbmcga2hpIGPhuqduIHPhu7EgdHLh
u6MgZ2nDunAgY+G7p2EgYuG6oW4uIFTDtGkNCnZp4bq/dCB0aMawIG7DoHkgY2hvIGLhuqFuIHbh
u5tpIG7hu5dpIGJ14buTbiBu4bq3bmcgbuG7gSB0cm9uZyBsw7JuZywgdMO0aSDEkcOjIGNo4buN
biBjw6FjaA0KbGnDqm4gbOG6oWMgduG7m2kgYuG6oW4gcXVhIEludGVybmV0IHbDrCBuw7MgduG6
q24gbMOgIHBoxrDGoW5nIHRp4buHbiBsacOqbiBs4bqhYyBuaGFuaA0KbmjhuqV0Lg0KDQpUw7Rp
IGzDoCBiw6AgVGhlcmVzYSBIZWlkaSA2MiB0deG7lWkgaGnhu4duIMSRYW5nIG7hurFtIHZp4buH
biB04bqhaSBt4buZdCBi4buHbmggdmnhu4duDQp0xrAgbmjDom4g4bufIElzcmFlbCBkbyBi4buL
IHVuZyB0aMawIHBo4buVaS4gVMO0aSDEkcaw4bujYyBjaOG6qW4gxJFvw6FuIG3huq9jIGLhu4du
aCB1bmcNCnRoxrAgcGjhu5VpIGPDoWNoIMSRw6J5IDQgbsSDbSwgbmdheSBzYXUgY8OhaSBjaOG6
v3QgY+G7p2EgY2jhu5NuZyB0w7RpLCBuZ8aw4budaSDEkcOjIMSR4buDDQps4bqhaSBjaG8gdMO0
aSB04bqldCBj4bqjIG5o4buvbmcgZ8OsIGFuaCDhuqV5IGPDsy4gVMO0aSDEkWFuZyBtYW5nIHRo
ZW8gbcOheSB0w61uaA0KeMOhY2ggdGF5IGPhu6dhIG3DrG5oIHRyb25nIG3hu5l0IGLhu4duaCB2
aeG7h24sIG7GoWkgdMO0aSDEkWFuZyDEkWnhu4F1IHRy4buLIHVuZyB0aMawDQpwaOG7lWkuDQoN
ClTDtGkgY8OzIG3hu5l0IGtob+G6o24gdGnhu4FuIMSRxrDhu6NjIHRo4burYSBr4bq/IHThu6sg
bmfGsOG7nWkgY2jhu5NuZyBxdcOhIGPhu5EgY+G7p2EgbcOsbmgsIHPhu5ENCnRp4buBbiBt4buZ
dCB0cmnhu4d1IGhhaSB0csSDbSBuZ2jDrG4gxJHDtCBsYSBjaOG7iSAoMS4yMDAuMDAwIFVTRCku
IHRp4buBbiBuw6B5IG7hu69hLg0KQsOhYyBzxKkgxJHDoyBraGnhur9uIHTDtGkgaGnhu4N1IHLh
urFuZyB0w7RpIHPhur0ga2jDtG5nIHRo4buDIHThu5NuIHThuqFpIHRyb25nIHbDsm5nIG3hu5l0
DQpuxINtIGRvIHbhuqVuIMSR4buBIHbhu4EgdW5nIHRoxrAgcGjhu5VpLg0KDQpT4buRIHRp4buB
biBuw6B5IHbhuqtuIMSRYW5nIOG7nyBuZ8OibiBow6BuZyBuxrDhu5tjIG5nb8OgaSB2w6AgYmFu
IHF14bqjbiBsw70gxJHDoyB2aeG6v3QgdMO0aQ0KbMOgIGNo4bunIHPhu58gaOG7r3UgdGjhu7Fj
IHPhu7EgxJHhu4MgxJHhur9uIG5o4bqtbiB0aeG7gW4gaGF5IMSRw7puZyBoxqFuIGzDoCBj4bql
cCBnaeG6pXkg4buneQ0KcXV54buBbiBjaG8gYWkgxJHDsyBuaOG6rW4gdGhheSB2w6wgdMO0aSBr
aMO0bmcgdGjhu4MgxJHhur9uIG5o4bqtbiB2w6wgYuG7h25oIGPhu6dhIG3DrG5oLg0KLiBO4bq/
dSBraMO0bmcgdGjhu7FjIGhp4buHbiwgbmfDom4gaMOgbmcgY8OzIHRo4buDIGLhu4sgdOG7i2No
IHRodSBxdeG7uSB2w6wgxJHDoyBnaeG7ryBuw7MNCnF1w6EgbMOidS4NCg0KVMO0aSBxdXnhur90
IMSR4buLbmggbGnDqm4gaOG7hyB24bubaSBi4bqhbiBu4bq/dSBi4bqhbiBjw7MgdGhp4buHbiBj
aMOtIHbDoCBxdWFuIHTDom0gxJHhu4MNCmdpw7pwIHTDtGkgcsO6dCBz4buRIHRp4buBbiBuw6B5
IHThu6sgbmfDom4gaMOgbmcgbsaw4bubYyBuZ2/DoGkgc2F1IMSRw7Mgc+G7rSBk4bulbmcgcXXh
u7kgdOG7qw0KdGhp4buHbiDEkeG7gyBnacO6cCDEkeG7oSBuaOG7r25nIG5nxrDhu51pIGvDqW0g
bWF5IG3huq9uLiBUw7RpIG114buRbiBi4bqhbiB44butIGzDvSBjw6FjIHF14bu5DQrhu6d5IHRo
w6FjIG7DoHkgbeG7mXQgY8OhY2ggdGhp4buHbiBjaMOtIHRyxrDhu5tjIGtoaSBi4bqldCBj4bup
IMSRaeG7gXUgZ8OsIHjhuqN5IHJhIHbhu5tpDQp0w7RpLiDEkMOieSBraMO0bmcgcGjhuqNpIGzD
oCB0aeG7gW4gYuG7iyDEkcOhbmggY+G6r3AgdsOgIGtow7RuZyBjw7Mgbmd1eSBoaeG7g20gbGnD
qm4NCnF1YW4gdsOgIDEwMCUga2jDtG5nIGPDsyBy4bunaSBybyB24bubaSDEkeG6p3kgxJHhu6cg
YuG6sW5nIGNo4bupbmcgcGjDoXAgbMO9Lg0KDQpUw7RpIG114buRbiBi4bqhbiBkw6BuaCA0NSUg
dOG7lW5nIHPhu5EgdGnhu4FuIMSR4buDIHPhu60gZOG7pW5nIGNobyBt4bulYyDEkcOtY2ggY8Oh
IG5ow6JuIGPhu6dhDQpi4bqhbiB0cm9uZyBraGkgNTUlIHPhu5EgdGnhu4FuIHPhur0gZMOgbmgg
Y2hvIHZp4buHYyBsw6BtIHThu6sgdGhp4buHbi4gVMO0aSBz4bq9IMSRw6FuaA0KZ2nDoSBjYW8g
c+G7sSB0aW4gdMaw4bufbmcgdsOgIGLhuqNvIG3huq10IHThu5FpIMSRYSBj4bunYSBi4bqhbiB0
cm9uZyB24bqlbiDEkeG7gSBuw6B5IMSR4buDDQp0aOG7sWMgaGnhu4duIG1vbmcgbXXhu5FuIGPh
u6dhIHRyw6FpIHRpbSB0w7RpLCB2w6wgdMO0aSBraMO0bmcgbXXhu5FuIGLhuqV0IGPhu6kgxJFp
4buBdSBnw6wNCmPDsyB0aOG7gyBnw6J5IG5ndXkgaGnhu4NtIGNobyBtb25nIG114buRbiBjdeG7
kWkgY8O5bmcgY+G7p2EgdMO0aS4gVMO0aSBy4bqldCB4aW4gbOG7l2kNCm7hur91IGLhuqFuIG5o
4bqtbiDEkcaw4bujYyB0aMawIG7DoHkgdHJvbmcgdGjGsCByw6FjIGPhu6dhIG3DrG5oLCBsw6Ag
ZG8gbOG7l2kga+G6v3QgbuG7kWkNCmfhuqduIMSRw6J5IOG7nyBxdeG7kWMgZ2lhIG7DoHkuDQoN
CkVtIGfDoWkgecOqdSBxdcO9IGPhu6dhIGFuaC4NCkLDoCBUaGVyZXNhIEhlaWRpDQo=
