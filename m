Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65F629BBD
	for <lists+cgroups@lfdr.de>; Tue, 15 Nov 2022 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKOOOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Nov 2022 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKOOOx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Nov 2022 09:14:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FFDF3B
        for <cgroups@vger.kernel.org>; Tue, 15 Nov 2022 06:14:53 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 63so10702570iov.8
        for <cgroups@vger.kernel.org>; Tue, 15 Nov 2022 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzgGX4AwSt860hhHaRgKsA8hx2m0I67dk0IZRTCbtjk=;
        b=DK9O43bXYQ4oHSCqAw0cvvqjA0AeWgP3BS8CQYoWrTjInSk4u0ltesBRRRliFcrmQL
         3EC6tU99XedckjR5+llI9iZNMbuy8qCUvxwl5szFXFB4gInHEfHyqb4cprygwDKLRHhl
         DQZuBaZ1FM6GxYhMsbgmhH0f4mcbn99PjdrinICP3U5EJhxU3XbVeMKdesZb221K2tCM
         cCTp/mHe3JyeJUq84XMIDTd25eUWo4pkOn8rWmukGRLnomM9UhGU4zNdniBftY6aZUNI
         NMyPrIOi10OT9sc7W8GXy/vhcnuo2A0YpJc5/G9Wylvq6l9SpdU1l4mqPn8aENMWciLk
         VzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzgGX4AwSt860hhHaRgKsA8hx2m0I67dk0IZRTCbtjk=;
        b=shWWn8K3n8JHH3ORYWyrvweQQywKZiAKoWNP8JnNP47SQNBZsz4Ia+hwO6mT7dP55V
         VYZznER/sfpSby8zC/kHoRD28qCh8Z1itkLUl6y6+h9KjZkN7iDMGsSdb5MzaG8WEGm0
         Q+x325c2oUTDHMY/tuf04jD/cw61cEWhGySKgDJ4Hp/uh4M8XEEBoTED92ht2SJjKGCl
         OEeKNSYJbmBm2nGEDYgFMO5ynSzhkVVe40p56qV9JH/y2VbRexXaafe7VKXmqVQXFzE/
         TfUrDqS2XR0K1Y/rkIQ0hscc6pv6n2tP2nleEPzlrHfW4D1ZhsvbP6o1i2xf8dK2KfPn
         VlGw==
X-Gm-Message-State: ANoB5pl/6C3Ph6QwGxrt79c1no76t5Kn+A/qrhNAZJ1ggDtqtKzFxLLi
        i5bo95Lef4MhtZuyhNZbi79+4YC9znuUVLmuZQU=
X-Google-Smtp-Source: AA0mqf7iZ65n9iaoIiBi53qedE5sDN06twKXtey+QWvZWO05TQzP5j4YSLChgV41/cHiqAPL1CBAa6Uq0oSyO5ASoAE=
X-Received: by 2002:a05:6602:482:b0:6c6:8c6b:9c12 with SMTP id
 y2-20020a056602048200b006c68c6b9c12mr8152687iov.31.1668521691673; Tue, 15 Nov
 2022 06:14:51 -0800 (PST)
MIME-Version: 1.0
Sender: johntayor.00@gmail.com
Received: by 2002:a4f:f282:0:0:0:0:0 with HTTP; Tue, 15 Nov 2022 06:14:51
 -0800 (PST)
From:   Richard Wahl <richardwahlii18@gmail.com>
Date:   Tue, 15 Nov 2022 14:14:51 +0000
X-Google-Sender-Auth: 7Xme2QHWMTCTQW7v3-sHxOY0hdg
Message-ID: <CAOr2nrknSGN3FO0iuNR7aB7fd8GcfvhQ5gYyNzAaj5ggH-=6rg@mail.gmail.com>
Subject: =?UTF-8?Q?Sie_haben_eine_Spende_von_=E2=82=AC_1=2E200=2E000=2C00?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Hallo. Ihre E-Mail wurde f=C3=BCr eine Spende in einer bestimmten H=C3=B6he
vergeben. Antworten Sie mit Ihrem Namen und Ihrer Adresse,
Telefonnummer, um Ihnen dieses Geld zukommen zu lassen.

 Ignorieren Sie diese Nachricht nicht, da sie direkt an Sie gerichtet ist.

Rigards
Richard Wahl
