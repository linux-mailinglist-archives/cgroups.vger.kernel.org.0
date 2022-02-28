Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23D4C695A
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiB1LHE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 06:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiB1LHD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 06:07:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCB66F89;
        Mon, 28 Feb 2022 03:06:23 -0800 (PST)
Date:   Mon, 28 Feb 2022 12:06:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646046380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuYSAt1MZUM/puwk3yZe7khsCEtHcjgvevbbDPW87Zk=;
        b=LhXrKps5NOhICMcZKstR1+jE06JIFDHGjkMlKSATJoZgFQyZ8pK2n5VWwZri6sGMljWH9g
        6WLE0k08QFMolOr516NBCQZ3vGUTVimY6xVTLdEBJfTOf3VGOPv7gAxHMMCyqYysM97V8+
        18+EXOf5bzfsoi9/qExuIC+mncp8HDV30K23ZwWHfDtnjmRQaEHjcBAH+8cCHOcP2MtfLz
        W6DFUWJjy97Y+hOwOPzo9IyuYGt/GXbD9CYsWZkHYTED/5c+aRyYszrRFpxO+nUkwD5RLq
        Ic2vobdPqB8lalkJ6UbsRkbK8vqOFoTLuQTiwxvJXmZ0RqFKM266ujgKTUYCrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646046380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuYSAt1MZUM/puwk3yZe7khsCEtHcjgvevbbDPW87Zk=;
        b=iBu5w7qyoK/y+oosN2Cvtf8iwCsNS0eYQ8x4WLqriihNBzWDKhtLPmKfRL/IkcMYx1cZ4G
        vqvOGjGC4TnBxNAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] linux-next test error: WARNING in
 __mod_memcg_lruvec_state
Message-ID: <YhysqzlMHWTXLR4B@linutronix.de>
References: <000000000000c7fde605d8e6b085@google.com>
 <20220227220943.490fb7b5f7c57d872f9523cb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220227220943.490fb7b5f7c57d872f9523cb@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git 71d365035711aef4c4b1018d02fcf7868e3cb0c5

On 2022-02-27 22:09:43 [-0800], Andrew Morton wrote:
> (cc bigeasy)
> 
>                         WARN_ON_ONCE(!irqs_disabled());
> 
> in __mod_memcg_lruvec_state(), methinks.

This report ist from before you added
   mm-memcg-protect-per-cpu-counter-by-disabling-preemption-on-preempt_rt-where-needed-fix.patch

to your tree. So it can be ignored. The next -next tree should be fine.

Sebastian
