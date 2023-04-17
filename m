Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B66E53B7
	for <lists+cgroups@lfdr.de>; Mon, 17 Apr 2023 23:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDQVNp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Apr 2023 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQVNo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Apr 2023 17:13:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CBF4232
        for <cgroups@vger.kernel.org>; Mon, 17 Apr 2023 14:13:44 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id ca22-20020a056830611600b006a3c1e2b6d2so15333060otb.13
        for <cgroups@vger.kernel.org>; Mon, 17 Apr 2023 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681766023; x=1684358023;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=neXrgl21jWf+esSEny2I/qO4MgNVx6+3OgHXBx9QHoslgj1BIl0Z7gez+feDVOcBeo
         Y6SW6E8Y0G2vOBMvGxFL3vSYKgSCvNeXLWBYkje/08xWoqzXEaCvGjjk+Whtt1qzp8JS
         FCuDUEQdm4ARMXW6KbrAsFy2jygyuoCYa29crS5+iE8Cx03QWM/y0VfMolMt+xvngOxo
         t2T5r/WVAvDz7vbYm6L5b8LYPFVqSezoUCRMLfwJbaXqVzAlpJhTWS9PcSMdtvp9PTBB
         LE8yao39UUVhLhjc3B5dMQfIPIZrJaVgq8WIIzMOwI4J/mXPE/pPZbp+Q8m/Z/4KSzGP
         5Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766023; x=1684358023;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=g1OLSAHDx/zMIaIO9hid6YCgZ2O/GuJfYpGycOzsvsWIL8v3sRnS2HoZE/7vtuuFlu
         urqxLljAfrjCnzFOiBqlOM++H3ojSVvmB0APP9f/4l7riNm+paxcnTVBNqephPV6J5S1
         eUYSp5NQFWvN++RWjSJ/TGe2oEzy6ywEfwm/njWAKPqVWsxJvfH6G9F0la3AK8TpQjQl
         CuTO8ozZYoD464+LGhBnvVQ1gOXbyj5AVJoSPki1tMMhOJsGb3BdroHxyvndjVhpMLn7
         qcqf2td4mR4fG8Agzqw0g8MEsy6j+hrwYc5uQSitRM5+v1c9JlsxUp1pefQ3wHwHcMNI
         jj+A==
X-Gm-Message-State: AAQBX9cJx206i1FOMV52FRxRRfeQVOTjil8XQ3RF/bYEDWLY7qqCp+Lo
        FPcvSdwesx4xcXf7mFni78gV1Cup1EcW+BqAHyA=
X-Google-Smtp-Source: AKy350bk1yTWqjhq9x+dXKnAdC5ouqjEIGokY9GmDhNJvcQijw+o7zfMjg+OSbJGfo7xpBgcyRcFfuJvj1a+YNQNT/A=
X-Received: by 2002:a9d:65da:0:b0:6a5:f7a6:2b75 with SMTP id
 z26-20020a9d65da000000b006a5f7a62b75mr126985oth.6.1681766023402; Mon, 17 Apr
 2023 14:13:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:53a3:b0:eb:2716:3f1d with HTTP; Mon, 17 Apr 2023
 14:13:43 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   Nina Coulibaly <regionalmanager.nina@gmail.com>
Date:   Mon, 17 Apr 2023 14:13:43 -0700
Message-ID: <CAHTAA8qrc2PEwvz7JO+DpCd6qftDezLgSbTWxEuwWWyGdEbL6w@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
