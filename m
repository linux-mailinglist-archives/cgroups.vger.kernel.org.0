Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7AE5006A4
	for <lists+cgroups@lfdr.de>; Thu, 14 Apr 2022 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiDNHMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbiDNHL4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 03:11:56 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFCAAE51
        for <cgroups@vger.kernel.org>; Thu, 14 Apr 2022 00:09:33 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e71so7808326ybf.8
        for <cgroups@vger.kernel.org>; Thu, 14 Apr 2022 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=iDCpUonGeNaCJXRMdr6vYmxcKF/myS9p15qnUMHiNJDFMpXlzPt3JQQEHmzT1Y3uoL
         3XNS/etG68Zx4UJhEVJOSmOFgbnLdB1iyQfQd+X8GbC+6BEv1Pv5Uwq37ZwlXP2Q+KRF
         r+0mpkDhENBdAvD5k+0g9RCfrk29XpzS5VFq7RwrlTKxoi7dSo/MtSUEH62uztsbuiPR
         msAeP55Q78GMvM04iKMecHKrc2z/Vvg66j1aldyG5V0jzsKagEz2Dd9Q5U6NJTPnAwQx
         mUc/LFPDkVN/+D/7jeNyDt55z91rTBm1jsuIA4B2EnL+qxE0BFbU33r16gfTJMS9ys+R
         Jugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=MDyrNGz3W0GmVcsuUz160mEAfnH++zJW8pcckk0/nZoB/L1ub+LhYwSYqhDIH/QFTS
         FmCsUJrk9or5e028qfjz60D84owUtjE/Mibpf8a+r6C/TR4015ZoCU1lO9R4hwtPSNOt
         fomlrrHK87xIZHWXAQoGSJYwz7n6YEDNSFBlnW9v+2rYcjxfnW7vFZSgDQSMQaumQqNB
         +2ixcyU+kb5JWu72eUSZEe6IvuKB3wUBxKIhRTO6dUBT+ocjAOqO3xA0O/PiGNJRQA9J
         uyiKTWoSL0Ch31w2hk8XjHDcL0iVAdx1FHii58toJucaTIYzWkbdra++X/naJYbo3vh7
         +HmQ==
X-Gm-Message-State: AOAM530cE8Uwnkiyv0T8O5rwElhIr1KtCFhKD7bpig8SGTzReNnedJJg
        1MM/Qrdi01REMA/OIrPrZ6vmF+uWPWQjfVc+SVk=
X-Google-Smtp-Source: ABdhPJxaY8DQz3yN+4Pvm32folzfjhudOZOOIZkjgQoaEg0xcdbEgAzCSfXCrj9MqMRQJIW3Swp5dJqLEiGHS3gserg=
X-Received: by 2002:a25:7b41:0:b0:641:26a9:9be3 with SMTP id
 w62-20020a257b41000000b0064126a99be3mr772329ybc.163.1649920171301; Thu, 14
 Apr 2022 00:09:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:a822:b0:247:d9b3:22bc with HTTP; Thu, 14 Apr 2022
 00:09:30 -0700 (PDT)
Reply-To: danielseyba@yahoo.com
From:   Seyba Daniel <mohaseen949433@gmail.com>
Date:   Thu, 14 Apr 2022 09:09:30 +0200
Message-ID: <CAOnm=ucO2rj5kjL=O4UgP+EmPTZVO8yn7OM4iBrEZXVPwQjPzA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mohaseen949433[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mohaseen949433[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
