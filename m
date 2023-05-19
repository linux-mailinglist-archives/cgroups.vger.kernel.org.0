Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805DF7091C0
	for <lists+cgroups@lfdr.de>; Fri, 19 May 2023 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjESIgo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 May 2023 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESIgn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 May 2023 04:36:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1BE52
        for <cgroups@vger.kernel.org>; Fri, 19 May 2023 01:36:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso3789758a12.1
        for <cgroups@vger.kernel.org>; Fri, 19 May 2023 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684485401; x=1687077401;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=crnWsy4rTCMVcubNwihjkZXB2rk4CYD1NFKDLVeSu0TFLfwMqj9QFJoy/DM3LXQ2L5
         WxCThnmzZwJqYPJ9oEvh1zlF61mn26NMau7uRTfIVhKewuYHhlyN9cwQEZfppbi6ThU8
         A5Lgyxrarkhzc81U9RQqptnQNMIng+4g6fArN4J/cF74IlQpNyBxnhRRrvapmw9rrnbk
         pP1XPqICSR7xfPn/K8cZR1IgFfY+ycnRWPTkoeYVSo1jkYim+K/M7Ky2Vvr3GlDDYQLO
         4/p8OHiMXrwP26H8yTqrRiDCn5xTa1srM2w2MmIcoEcEpP1g/0/omzymjGBCeaPSNZ1j
         s1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485401; x=1687077401;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=DtSUNEySKGmroOqQbEcPz+44ovMQl9RCJAASY6tsavDup9i9N/qWnUNuUAjvHz+3Tb
         zQUbgYcdoYB//EsTxES+8iatQ2CZVDEZmUoGsqblIcm6beoVG2nQ+MrQek8bV7no1wZs
         WgQUBn2SMPoV1donTN50QxwMoUCzMetzor1MPjjuSXqhGw9gCth/AEkm7ulb95/fuz1o
         81Zj9i03voNA2knBKGvW8e3Zu3Bj+BcDGfte5ru8g8KOJits1ZaHt/OIgC8NsmC9cQ4C
         h+OSes7OTBSHBq+DT02ev3iPspTH3C56BE/cTRoS28Bxa+Wcqkrf71xxSKh9t7tzQZnu
         vNNw==
X-Gm-Message-State: AC+VfDzjP3mapqSrla/EFzssnd7izzLhmnmufBELjrxoXIx+XbE3ShaK
        PPtRfqu14vkqkEINLqPMlrjixCW1cBEK2Vd0vCw=
X-Google-Smtp-Source: ACHHUZ7uw52qpsxeUuXpvmmOKEC55lFEyS5Wy/0ygSEE6oBP4SVDYJHAcZWt263W/q2nC9Zo07/aXs2YHCU8RFZty2Y=
X-Received: by 2002:aa7:cccc:0:b0:50b:c0ce:d55 with SMTP id
 y12-20020aa7cccc000000b0050bc0ce0d55mr990207edt.3.1684485400435; Fri, 19 May
 2023 01:36:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:4054:b0:69:6979:70f7 with HTTP; Fri, 19 May 2023
 01:36:40 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly79.info@gmail.com>
Date:   Fri, 19 May 2023 01:36:40 -0700
Message-ID: <CAA+U+NKR8Zbm7D=cjXQDLtv+A=42nkArQwEEQ9mT9pYQUxffDQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
