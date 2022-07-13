Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD5573DEA
	for <lists+cgroups@lfdr.de>; Wed, 13 Jul 2022 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiGMUme (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jul 2022 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGMUma (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jul 2022 16:42:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5031341
        for <cgroups@vger.kernel.org>; Wed, 13 Jul 2022 13:42:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m16so15594394edb.11
        for <cgroups@vger.kernel.org>; Wed, 13 Jul 2022 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=djklwqhRzHhoIXJKwJ2MAdBZ1kfHAMR9TrUfOA6tBhnbYyp8Req/YodjgTib0TxU8G
         BvzrobXgPwqbrvz/hooEz+z8jzDp+N3bzXfSE1I/NNyJJNVjVo+CqCGYPmpUWjJWc9EO
         zaYDwJuqPjukgeU6nGBHux76GF39CIrfTZ04Ejvw0XU5OJjZ1Zv+pw5EeOWiiNmsdxqS
         nZtEGNQfDVxKDReqb5A46s9pAcZzXl8SbNq4u/+BK5SD5IH3lHcqGfANPtVrCkLiX48A
         m+/sOvni7BXGUCX/W36lkagtrrT1vRM63Ja6SRvqYwoWHM5OSbwtk18yuwRuBx7Tj7B2
         PJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=zvEH8R8jJMJzbjJ2vmFoy2fkQHYeWOqLD/YJI6mRXn5rfGtgNHw862CP/x9f420Lm7
         8f/F2vegUM4s6EtmZ8IMKP/lHhW5/zn8fl4MuiPUFES4E+AL4OFaNp5EuemG8D0WQrIW
         SiJbDJJnirvUeNIqZqy1/Qv67O7y2V6oCYcwdLSxtdpBZjJkLlh2vSmoU0bCRja3KGUf
         8Wn92ou3c25rf4FYjKu4rqUPx6C+y1E3nzYvLUcypcRfz4BjfJCjh5LIZH8bAz/whAF/
         NgbQIow818WGcGUX/6TPZxpgQocCDhGrZYD29J1gELDulsFRRz/6HGfHWq8lEzfchhki
         oQkw==
X-Gm-Message-State: AJIora8H3Ww2leZbGmhb5lI360qaKL/f2wQC+Wr1FdnQJySYyRzWtUPx
        ee/32K/yuSZ+a6sTjL4Uac79dfpvjDYUzvcUr9E=
X-Google-Smtp-Source: AGRyM1sT86s6WxxMsOSxvE+Zm9ubkhtGvoJnkOWkenKXUPSy4iwdm2Ex1/iZLanwqMWGdptnryK9jDedxiHFPgcu6jg=
X-Received: by 2002:a05:6402:35d1:b0:43a:cb5b:208b with SMTP id
 z17-20020a05640235d100b0043acb5b208bmr7478754edc.275.1657744948317; Wed, 13
 Jul 2022 13:42:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:1c06:b0:72d:5fc7:686 with HTTP; Wed, 13 Jul 2022
 13:42:27 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <savadogoidrissaboursouma@gmail.com>
Date:   Wed, 13 Jul 2022 12:42:27 -0800
Message-ID: <CAA6zzo=8xp31YajAt9vLdr55bjMGsbs6r6Csv9bGO-S3c+t0wA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [savadogoidrissaboursouma[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
