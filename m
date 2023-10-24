Return-Path: <cgroups+bounces-62-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F17D57B5
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C52A1C20C0E
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7743993E;
	Tue, 24 Oct 2023 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TOKvoMev"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B0200CC
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:13:54 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A310C2;
	Tue, 24 Oct 2023 09:13:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 136262188C;
	Tue, 24 Oct 2023 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698164031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65G5ZNQWiDjqZVlLnnNnzZnK3gIH0P1VMKPcZjBriZw=;
	b=TOKvoMevPK9ep1x5Y2CeGPRRLW0DAGWpE6ozaK8R+CC/sxs3PwbkaAoHUQqKadsBI7W5CT
	8medDQxT17HuuX36Ew6x5AEaX+tYoYm9IGay5lKwvgK5sx5/PyJlXgrZ+S25XTGRmaLrxl
	tUF+0blB2NJIJsdSqHNta8nTaylXRN4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C98321391C;
	Tue, 24 Oct 2023 16:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qXU6MD7tN2UIZAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Tue, 24 Oct 2023 16:13:50 +0000
Date: Tue, 24 Oct 2023 18:13:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner <brauner@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Message-ID: <agjgbmdi2yqegjk7p7m52yb3wxmr64ivohbra5wapcd3lwynpw@jjmx6dsboo53>
References: <20230905133243.91107-1-longman@redhat.com>
 <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
 <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri, Oct 13, 2023 at 12:03:18PM -0400, Waiman Long <longman@redhat.com> wrote:
> > [chain]
> >    root
> >    |                           \
> >    mid1a                        mid1b
> >     cpuset.cpus=0-1              cpuset.cpus=2-15
> >     cpuset.cpus.partition=root
> >    |
> >    mid2
> >     cpuset.cpus=0-1
> >     cpuset.cpus.partition=root
> >    |
> >    cont
> >     cpuset.cpus=0-1
> >     cpuset.cpus.partition=root
> In this case, the effective CPUs of both mid1a and mid2 will be empty. IOW,
> you can't have any task in these 2 cpusets.

I see, that is relevant to a threaded subtree only where the admin / app
can know how to distribute CPUs and place threads to internal nodes.

> For the remote case, you can have intermediate tasks in both mid1a and mid2
> as long as cpuset.cpus contains more CPUs than cpuset.cpus.exclusive.

It's obvious that cpuset.cpus.exclusive should be exclusive among
siblings.
Should it also be so along the vertical path?

  root
  |                           
  mid1a                       
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=0    
  |
  mid2
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=1
  |
  cont
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=2
   cpuset.cpus.partition=root

IIUC, this should be a valid config regardless of cpuset.cpus.partition
setting on mid1a and mid2.
Whereas

  root
  |                           
  mid1a                       
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=0    
  |
  mid2
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=1-2
   cpuset.cpus.partition=root
  |
  cont
   cpuset.cpus=1-2
   cpuset.cpus.exclusive=1-2
   cpuset.cpus.partition=root

Here, I'm hesitating, will mid2 have any exclusively owned cpus?

(I have flashes of understading cpus.exclusive as being a more
expressive mechanism than partitions. OTOH, it seems non-intuitive when
both are combined, thus I'm asking to internalize it better.
Should partitions be deprecated for simplicty? They're still good to
provide the notification mechanism of invalidation.
cpuset.cpus.exclusive.effective don't have that.)

> They will be ready eventually. This requirement of remote partition actually
> came from our OpenShift team as the use of just local partition did not meet
> their need. They don't need access to exclusive CPUs in the parent cgroup
> layer for their management daemons. They do need to activate isolated
> partition in selected child cgroups to support our Telco customers to run
> workloads like DPDK.
> 
> So they will add the support to upstream Kubernetes.

Is it worth implementing anything touching (ancestral)
cpuset.cpus.partition then?

Thanks,
Michal


