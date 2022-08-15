Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC39592C1F
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiHOJGB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHOJGA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 05:06:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B0BC8F;
        Mon, 15 Aug 2022 02:05:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5BE03486C;
        Mon, 15 Aug 2022 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660554357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wmyLVShEDIO9zR9fd/Zd6KIwqvJ7WmFq3Q+f4veJxx4=;
        b=Hr7FJApvmpacg+qsEsJ9ov0c/tj4crcwwKaC5VvYz8JZ5R2TTE2h7cECeD9EJfzdYfYWAc
        cN6spABRKoxVA3aiXtRq3fSz0vQiAI+DH1UU/0eoeqEB7IGt1oHlgnYia5D4+XmpkvfT97
        uWu7YDaPLs1jhiKEkKAQrGk8nHMwqEU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9321913A93;
        Mon, 15 Aug 2022 09:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lVbSInUM+mLXTwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 15 Aug 2022 09:05:57 +0000
Date:   Mon, 15 Aug 2022 11:05:56 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Tejun Heo <tj@kernel.org>, Imran Khan <imran.f.khan@oracle.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, tglx@linutronix.de,
        steven.price@arm.com, peterz@infradead.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Message-ID: <20220815090556.GB27407@blackbody.suse.cz>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org>
 <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Cc: Zhao Gongyi <zhaogongyi@huawei.com>, Zhang Qiao <zhangqiao22@huawei.com>

On Fri, Aug 12, 2022 at 03:57:00PM +0530, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> The original patch of yours [1]  and the revert of [2] is fixing the issue
> and it is also confirmed here [3].
> Can we get proper fix merge on your tree?
> 
> [1] https://lore.kernel.org/lkml/YuGbYCfAG81mZBnN@slm.duckdns.org/
> 
> [2]
> https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.com/

The revert + Tejun's patch looks fine wrt the problem of the reverted
patch (just moves cpus_read_lock to upper callers).

I'd just suggest a comment that'd explicitly document also the lock
order that we stick to, IIUC, it should be:

	cpu_hotplug_lock // cpus_read_lock
	cgroup_threadgroup_rwsem
	cpuset_rwsem

Michal

> 
> [3] https://lore.kernel.org/lkml/CAB8ipk-72V-bYRfL-VcSRSyXTeQqkBVj+1d5MHSVV5CTar9a0Q@mail.gmail.com/
> 
> -Mukesh
