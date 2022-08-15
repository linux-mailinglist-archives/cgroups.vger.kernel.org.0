Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A1592CA2
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiHOJjk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHOJjj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 05:39:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F71EC61;
        Mon, 15 Aug 2022 02:39:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EFDD34AAE;
        Mon, 15 Aug 2022 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660556377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLRt920Q9NTts46M0mpTJHEHc61MGrl7arvYDWKeJLY=;
        b=E9YwOiQ68gGhWyMiRiOYeVdDaQUKtIKU4zieATyAoF5818GH7zRobg+wLoG3UwPtQKb233
        Roaao9shepnktb6xBF9IfdPMSvpitaha+8BA5ugV3cQ6r89TiNLeMq9Chvtl8BB3hKc02/
        qpcsakl9FCZQX72Lr9LuVDej/1rrTUc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BADFB13A93;
        Mon, 15 Aug 2022 09:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6U+RLFgU+mIvXwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 15 Aug 2022 09:39:36 +0000
Date:   Mon, 15 Aug 2022 11:39:35 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, Tejun Heo <tj@kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Message-ID: <20220815093934.GA29323@blackbody.suse.cz>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org>
 <YuGTBLkFerUboctl@slm.duckdns.org>
 <dc0cff0e-b744-9d5d-e727-70d1c31b2a74@quicinc.com>
 <20220815090556.GB27407@blackbody.suse.cz>
 <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk90LxNNbq5OKamd-ArkqhEZjxS1fFZJXtnbQwGzyyJ3wQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 15, 2022 at 05:25:52PM +0800, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> Your means is that the problem should be fixed by [1]+[2]'s revert ?

I understood that was already the combination you had tested.
You write in [T] that [1] alone causes (another) deadlock and therefore
the revert of [2] was suggested.

> I just tested the case which reverted the [2]. Need I test with [1] and [2]?

It'd be better (unless you haven't already :-), my reasoning is for the
[1]+[2] combo.

Thanks,
Michal

[T] https://lore.kernel.org/r/CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com/
