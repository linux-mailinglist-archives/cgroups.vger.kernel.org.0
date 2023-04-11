Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5216DDBCC
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjDKNMp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDKNMn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 09:12:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7B10FF;
        Tue, 11 Apr 2023 06:12:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDE151FD6A;
        Tue, 11 Apr 2023 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681218755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNlFRQuYhtU71A5sBtEqauVXSAM4+ELeuv9fRTR/B+8=;
        b=N3D9s54Cj7iVAGl3df2xdmODccoQe5g3gpxR/8FgOto6W6miPDufLxBAI1dKerUC33V0e3
        ZmdpqwbnwZywWA363KMPUG+hVUJK90Uivdmur+G67+EBIcBRhGlxkSg+zch2ZVqdDRD49O
        qdirTKxhGLmkRu86zzmZkrGX169YhMc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAB8113519;
        Tue, 11 Apr 2023 13:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DFM+J8NcNWQMLQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Apr 2023 13:12:35 +0000
Date:   Tue, 11 Apr 2023 15:12:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4] mm: oom: introduce cpuset oom
Message-ID: <ZDVcwuiu3rWEFiTE@dhcp22.suse.cz>
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
 <aa3382b4-4046-988f-42ea-8812dba7882b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa3382b4-4046-988f-42ea-8812dba7882b@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-04-23 21:04:18, Gang Li wrote:
> 
> 
> On 2023/4/11 20:23, Michal Koutný wrote:
> > Hello.
> > 
> > On Tue, Apr 11, 2023 at 02:58:15PM +0800, Gang Li <ligang.bdlg@bytedance.com> wrote:
> > > +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> > > +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
> > > +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
> > > +			while (!ret && (task = css_task_iter_next(&it)))
> > > +				ret = fn(task, arg);
> > > +			css_task_iter_end(&it);
> > > +		}
> > > +	}
> > > +	rcu_read_unlock();
> > > +	cpuset_read_unlock();
> > > +	return ret;
> > > +}
> > 
> > I see this traverses all cpusets without the hierarchy actually
> > mattering that much. Wouldn't the CONSTRAINT_CPUSET better achieved by
> > globally (or per-memcg) scanning all processes and filtering with:
> 
> Oh I see, you mean scanning all processes in all cpusets and scanning
> all processes globally are equivalent.

Why cannot you simple select a process from the cpuset the allocating
process belongs to? I thought the whole idea was to handle well
partitioned workloads.

> > 	nodes_intersect(current->mems_allowed, p->mems_allowed
> 
> Perhaps it would be better to use nodes_equal first, and if no suitable
> victim is found, then downgrade to nodes_intersect?

How can this happen?

> NUMA balancing mechanism tends to keep memory on the same NUMA node, and
> if the selected victim's memory happens to be on a node that does not
> intersect with the current process's node, we still won't be able to
> free up any memory.

AFAIR NUMA balancing doesn't touch processes with memory policies.
-- 
Michal Hocko
SUSE Labs
