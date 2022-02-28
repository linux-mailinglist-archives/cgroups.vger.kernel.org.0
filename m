Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64794C6957
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 12:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiB1LHC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 06:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiB1LHC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 06:07:02 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C365780
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 03:06:23 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id x9-20020a0566022c4900b0064289c98bf8so5497652iov.12
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 03:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=NGeRMKnns/CkUBI5ujUz37hjPuAcdJGxEeUdErwvJTg=;
        b=WYQQMPuCiuDUvlKXCrTtcgDZsPfNC4K4p6Hhr81Z22UGn3Yywl1HC7abKvP7Y45xIx
         V4FX8zI6V/IVTOfMPqnohoRBOTSixruDQVv7BPRfP5+aU+zzlUXlqlnDbRestr4U8t3K
         NWBASoAI+tnUvbOABy4w7t5G8MhnWj5u8/2HW3GQi8OGQUXWBrWHyQ5esiGYvQ3BNmIx
         0r/cttc0F+asxSS1ByC59wXQdD6CONAVt4UJqr8oUhkvUayjBlhNg0rbudYkrdzr2JGd
         D+InC4QIT87jnvFTsAzPJEqrKfdd9zu/KLx1u5ySmCTr+D/MZb29Y98PL0e8fRXmgJZq
         LKTw==
X-Gm-Message-State: AOAM533qzG5e7C9kkGnVEhA/JBeOUN+hr7BLWVk25uCRAmNvSxW5+ElB
        3MQKKfIqSutNEqQMjmebL91DpqMl7ccTLu9uiRO2K7LyNRaK
X-Google-Smtp-Source: ABdhPJxeTFVWqRcnYQKyeoUA5fs9iql/0PWMeiaUOHnhz5OQep44nI/xLdBW0DeoycNoFKhdyFNXJ09Y+uZkA9tshqS68Y5B1qpt
MIME-Version: 1.0
X-Received: by 2002:a02:b19e:0:b0:30d:d9f5:d03c with SMTP id
 t30-20020a02b19e000000b0030dd9f5d03cmr16825134jah.19.1646046382076; Mon, 28
 Feb 2022 03:06:22 -0800 (PST)
Date:   Mon, 28 Feb 2022 03:06:22 -0800
In-Reply-To: <YhysqzlMHWTXLR4B@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3387805d912097c@google.com>
Subject: Re: [syzbot] linux-next test error: WARNING in __mod_memcg_lruvec_state
From:   syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git 71d365035711aef4c4b1018d02fcf7868e3cb0c5

This crash does not have a reproducer. I cannot test it.

>
> On 2022-02-27 22:09:43 [-0800], Andrew Morton wrote:
>> (cc bigeasy)
>> 
>>                         WARN_ON_ONCE(!irqs_disabled());
>> 
>> in __mod_memcg_lruvec_state(), methinks.
>
> This report ist from before you added
>    mm-memcg-protect-per-cpu-counter-by-disabling-preemption-on-preempt_rt-where-needed-fix.patch
>
> to your tree. So it can be ignored. The next -next tree should be fine.
>
> Sebastian
