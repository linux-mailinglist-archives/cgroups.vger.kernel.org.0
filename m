Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFE44C4E6
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhKJQSF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 11:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhKJQSE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 11:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636560916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pujqTrjEVvmX1Jx376eksYnuy7UjFSMiFW1jzdmHKRE=;
        b=HKyWsFTy5AbnOGPcwQnm/29BaJ3R93f7cbU9kIxrHEirA+OFSH4zgICWg6CCJNUc76Gfer
        qz0O6jCs8Zr3Mp88KjTmwTg4fu4JJth7lcyv1JWioggh9w7wAfdid1u2cFP6hIJfekyLv0
        /jtjTkmZN7WLCTENVv2eBIGJVQkWPTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-8KJ_qktiNdOnouDFQhSRcg-1; Wed, 10 Nov 2021 11:15:13 -0500
X-MC-Unique: 8KJ_qktiNdOnouDFQhSRcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA423804145;
        Wed, 10 Nov 2021 16:15:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 038F017567;
        Wed, 10 Nov 2021 16:14:33 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 84D57416CE49; Wed, 10 Nov 2021 13:14:29 -0300 (-03)
Date:   Wed, 10 Nov 2021 13:14:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     "Moessbauer, Felix" <felix.moessbauer@siemens.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <20211110161429.GA22855@fuller.cnet>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
 <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211110161020.GA20101@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211110161020.GA20101@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 10, 2021 at 01:10:20PM -0300, Marcelo Tosatti wrote:
> On Wed, Nov 10, 2021 at 03:21:54PM +0000, Moessbauer, Felix wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Michal Koutn� <mkoutny@suse.com>
> > > Sent: Wednesday, November 10, 2021 2:57 PM
> > > To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>
> > > Cc: longman@redhat.com; akpm@linux-foundation.org;
> > > cgroups@vger.kernel.org; corbet@lwn.net; frederic@kernel.org; guro@fb.com;
> > > hannes@cmpxchg.org; juri.lelli@redhat.com; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-kselftest@vger.kernel.org;
> > > lizefan.x@bytedance.com; mtosatti@redhat.com; pauld@redhat.com;
> > > peterz@infradead.org; shuah@kernel.org; tj@kernel.org; Kiszka, Jan (T RDA
> > > IOT) <jan.kiszka@siemens.com>; Schild, Henning (T RDA IOT SES-DE)
> > > <henning.schild@siemens.com>
> > > Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
> > > empty effecitve cpus
> > > 
> > > Hello.
> > > 
> > > On Wed, Nov 10, 2021 at 12:13:57PM +0100, Felix Moessbauer
> > > <felix.moessbauer@siemens.com> wrote:
> > > > However, I was not able to see any latency improvements when using
> > > > cpuset.cpus.partition=isolated.
> > > 
> > > Interesting. What was the baseline against which you compared it (isolcpus, no
> > > cpusets,...)?
> > 
> > For this test, I just compared both settings cpuset.cpus.partition=isolated|root.
> > There, I did not see a significant difference (but I know, RT tuning depends on a ton of things).
> > 
> > > 
> > > > The test was performed with jitterdebugger on CPUs 1-3 and the following
> > > cmdline:
> > > > rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
> > > > On the other cpus, stress-ng was executed to generate load.
> > > > [...]
> > > 
> > > > This requires cgroup.type=threaded on both cgroups and changes to the
> > > > application (threads have to be born in non-rt group and moved to rt-group).
> > > 
> > > But even with isolcpus the application would need to set affinity of threads to
> > > the selected CPUs (cf cgroup migrating). Do I miss anything?
> > 
> > Yes, that's true. But there are two differences (given that you use isolcpus):
> > 1. the application only has to set the affinity for rt threads.
> >  Threads that do not explicitly set the affinity are automatically excluded from the isolated cores.
> >  Even common rt test applications like jitterdebugger do not pin their non-rt threads.
> > 2. Threads can be started on non-rt CPUs and then bound to a specific rt CPU.
> > This binding can be specified before thread creation via pthread_create.
> > By that, you can make sure that at no point in time a thread has a "forbidden" CPU in its affinities.
> > 
> > With cgroup2, you cannot guarantee the second aspect, as thread creation and moving to a cgroup is not an atomic operation.
> > Also - please correct me if I'm wrong - you first have to create a thread before moving it into a group.
> > At creation time, you cannot set the final affinity mask (as you create it in the non-rt group and there the CPU is not in the cpuset.cpus).
> > Once you move the thread to the rt cgroup, it has a default mask and by that can be executed on other rt cores.
> 
> man clone3:
> 
>        CLONE_NEWCGROUP (since Linux 4.6)
>               Create  the  process  in  a  new cgroup namespace.  If this flag is not set, then (as with fork(2)) the
>               process is created in the same cgroup namespaces as the calling process.
> 
>               For further information on cgroup namespaces, see cgroup_namespaces(7).
> 
>               Only a privileged process (CAP_SYS_ADMIN) can employ CLONE_NEWCGROUP.
> 

Err, CLONE_INTO_CGROUP.

