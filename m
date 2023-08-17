Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA277F2D8
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbjHQJM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349354AbjHQJM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 05:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450B2D63;
        Thu, 17 Aug 2023 02:12:27 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:12:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692263546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fp7L9O2Ivmey6Olx0dpGU5sez7ZYHKV4H6RchIR6KxA=;
        b=JRdvd/eKLOliRx3lLc3OTMoAtNH1lR95NU3kcFTs1+Vaz47YIH89WQJPPE5N1faSoHxq73
        uhQWcYl6nLdHRjQO0zajRdGpuJiacZ/gp36u9wC8rnaHp+fh7DxjxzW+CTL6PbVe4WWyWY
        M0CsF45ETpn5soMKQ5N8ezKyIjyM/kX+L5Hj+IsGfHi7AtA/t+R0sIQCr9efIz/d2AkJOJ
        pJ5Ip7SRtoTJjT7UnOMhWaFE/dOJ4m4RPuPoZhChn40GDt53KYlcjF8306Of2pjgh9V10n
        o/++k/BAXpNjnCTB30pRGmI4G2neZ4jgT3CIJ8Sd0Q1MXmT8PMCBVs9f4WERaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692263546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fp7L9O2Ivmey6Olx0dpGU5sez7ZYHKV4H6RchIR6KxA=;
        b=WWdAKbwMGiTgZxy+lMApDQ7tAQ4WREZhUatRs9g13frtT7w+0rU0CqNuzffADX+rcJww7v
        cJT1/UjiLILE95Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zachary.goldstein@concurrent-rt.com,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        stable-rt@vger.kernel.org
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] mm/memcg: Fix recursive locking on refill_stock() on
 PREEMPT_RT
Message-ID: <20230817091224.nqKGjRlK@linutronix.de>
References: <20230809-memcg-fix-recursive-lock-v1-1-0870815484c6@concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809-memcg-fix-recursive-lock-v1-1-0870815484c6@concurrent-rt.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023-08-10 15:05:34 [-0400], Zachary Goldstein via B4 Relay wrote:
> From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
> 
> 5.10 suffers from the same recursive locking issue that
> commit a848d25434de4 ("mm/memcg: Opencode the inner part of
> obj_cgroup_uncharge_pages() in drain_obj_stock()") fixes.

This is the commit id from the stable-rt tree for the v5.15 series.
The original commit was af9a3b69e84be ("mm/memcg: opencode the inner
part of obj_cgroup_uncharge_pages() in drain_obj_stock()").

> Modified description from the commit to reflect this patch changes:
> 
> Provide the inner part of refill_stock() as __refill_stock() without
> disabling interrupts. This eases the integration of local_lock_t where
> recursive locking must be avoided.
> Open code __memcg_kmem_uncharge() in drain_obj_stock() and
> obj_cgroup_release() and use __refill_stock(). The caller of
> drain_obj_stock() and obj_cgroup_release() already disables interrupts.
> 
> Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>

I would prefer a proper backport similar to the commit you mentioned.
This would include keeping the author ship and so on.
The change itself looks okay.

Sebastian
