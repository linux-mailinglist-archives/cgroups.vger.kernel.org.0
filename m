Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDB752C5D0
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiERV7E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiERV6d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 17:58:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849D185C83
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 14:48:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v11so3010368qkf.1
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=675CvuSp++zNLeIUZybBsP51nvc83dY+2bSGb3FYErQ=;
        b=iOG1NkLYKXzHVGbFXhkAU04rG0ZLdxjJJSruiiCEy1k0/bZIY3dbiKXaFzHdRsOr41
         2fcmkJYmpwQRN9gIJcmhssQGyE4cC1NLtuT7jD5i9+/O7no/Cvew1BGXQ01P+N9P2+3U
         KlrJhz9CthZNwrHX34gtcaECFmjjJqFQkHMRiyNeU0xh8cAdUuYUFC82XNhpkIc1YVN3
         w7FeK72c2pqfzVH+8MKXEdkHbZMjttZMqf9RqNzJ19lmPxKa5g5MRPDdfdgmTlBX21Yc
         fDb1nO8iFnGP6+G1RReudH0bUNrkqsbwAxE9QBu4jGlptpB7hBFDTgvKVYIhXeVAi233
         PjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=675CvuSp++zNLeIUZybBsP51nvc83dY+2bSGb3FYErQ=;
        b=o0+AWpYr3wcAyRGAaelyGetLwAH4L1LS6WmT33Iv0a3ye/Gcve2ggqbH7UlcZVT1xl
         ulCshuW1F9JMmy8ESC7FOsO/ELNDJiWhqmpNr7qldtgbjGaScRA6R2UPgHS29dcj+jFg
         XrazOj/feDqMVAqO1lRDo9CwsLqH2onJ+BwyY23aWtRBy3HDtVc7UeBYZANcR7ruAe1D
         lsYC49tt+hi2aqV0sI/i//3Zefo4RZMFeNfcCEwFvmm2jVsnieAbPvZh6azKmTIQmvl1
         aC4oJ9rWHUyeTftbuyvBVLskIkV3DOz4twj0hVD58tzrBFNWvDsNATKU4XYR2ZaWDBvf
         IMSw==
X-Gm-Message-State: AOAM530pCSCcUNGEqDJI5J1ubiZHO5G7p3wAXmRp7/PoDk4N5+4wApZC
        mSVsnSYVsEAspyC3HStV+jrpVPte0aN4FYvDc7I=
X-Google-Smtp-Source: ABdhPJxVkbr9Uwk2L1NFh6yfL5XTLIbM2+J59AMFzDYEPt2zICLnQ921qh7vAWefgwMneAr9Ho4CXxLFf3guNLuO4FU=
X-Received: by 2002:a05:620a:4104:b0:6a0:68b3:b004 with SMTP id
 j4-20020a05620a410400b006a068b3b004mr1136542qko.173.1652910497295; Wed, 18
 May 2022 14:48:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5cc1:0:0:0:0:0 with HTTP; Wed, 18 May 2022 14:48:17
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <thompsonmiller942@gmail.com>
Date:   Wed, 18 May 2022 17:48:17 -0400
Message-ID: <CAN7gJ1QbrVyG3wUk1can6_szbAR23r-oKm78ejuM3nDt5+94ow@mail.gmail.com>
Subject: work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:732 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4908]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [thompsonmiller942[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [thompsonmiller942[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Can you work with me?
