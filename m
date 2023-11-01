Return-Path: <cgroups+bounces-151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F07DE5B7
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D461C20DFA
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C91862A;
	Wed,  1 Nov 2023 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="qM2zxQN2"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAC107B5;
	Wed,  1 Nov 2023 18:01:07 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F5DB;
	Wed,  1 Nov 2023 11:01:02 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 75CDA10002E;
	Wed,  1 Nov 2023 21:01:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 75CDA10002E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698861661;
	bh=jIzkCOAsxzsZyUPpf4PMSJ8DkN9Rq4L3fIcg/MsOg3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=qM2zxQN2FLLGqFwiWnPfrF/q3ja3mR4ffQ8rzrqYq0YWzs3doh17zKfPYrcABdyPz
	 4FBuaWUGqwQb4qbLQ1nY0s5s4XzOjVO5A/vn3b+x/w2pUzk33AG1mdfySd1Fgcwoee
	 ysqf8hcb6ySLsohlYnd6Ira0PFBT/CeaXoah7lBzGI+cdKA48lE29ulAE1pkVV9npC
	 kQq8xvsSQWqFjfmPrs7ckgxdnlKBX0U5ers4vAggtxOKkOj40L5bsQP2/P18+bQFq8
	 4fYztD9uM5NIKu6GyJzcbL3Mxm8o0VwMR+AepjZzCWTH9Y38wnwp9NeZuLrbUiBsKA
	 ZhQ1Uybi+Er0Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 21:01:00 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 21:01:00 +0300
Date: Wed, 1 Nov 2023 21:00:54 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] mm: memcg: print out cgroup name in the memcg
 tracepoints
Message-ID: <20231101180054.ihczece7upxla77u@CAB-WSD-L081021>
References: <20231101102837.25205-1-ddrokosov@salutedevices.com>
 <20231101102837.25205-2-ddrokosov@salutedevices.com>
 <CAEf4BzZ0p-k15XLf2QdHNN6TodjRBtRKk2mvsttCj=GUi4Or3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ0p-k15XLf2QdHNN6TodjRBtRKk2mvsttCj=GUi4Or3A@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181058 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 15:56:00 #22380151
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Andrii!

Thank you for quick feedback!

On Wed, Nov 01, 2023 at 10:08:34AM -0700, Andrii Nakryiko wrote:
> On Wed, Nov 1, 2023 at 3:29 AM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > Sometimes it is necessary to understand in which memcg tracepoint event
> > occurred. The function cgroup_name() is a useful tool for this purpose.
> > To integrate cgroup_name() into the existing memcg tracepoints, this
> > patch introduces a new tracepoint template for the begin() and end()
> > events, utilizing static __array() to store the cgroup name.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++------
> >  mm/vmscan.c                   |  8 ++--
> >  2 files changed, 69 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index d2123dd960d5..124bc22866c8 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -141,19 +141,47 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_b
> >  );
> >
> >  #ifdef CONFIG_MEMCG
> > -DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
> >
> > -       TP_PROTO(int order, gfp_t gfp_flags),
> > +DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
> >
> > -       TP_ARGS(order, gfp_flags)
> > +       TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_flags),
> > +
> > +       TP_ARGS(memcg, order, gfp_flags),
> 
> By adding memcg in front of existing tracepoint arguments, you
> unnecessarily break everyone who currently has some scripts based on
> this tracepoint. Given there is no reason why memcg has to be the very
> first argument, it would be nice if you can just append it at the end
> to make it nicely backwards compatible. Same for other tracepoints
> below.
> 
> Tracepoints are not an ABI, but there is also no point in arbitrarily
> breaking all current scripts for such a trivial reason.
> 

You are absolutely correct. I didn't consider the scripts that rely on
these tracepoints, because tracepoints are not an ABI, as you mentioned.
Additionally, I added the memcg parameter as the first argument based on
my personal programming patterns, where the context object should always
come first :)

I apologize for that and will prepare new version.

> > +
> > +       TP_STRUCT__entry(
> > +               __field(int, order)
> > +               __field(unsigned long, gfp_flags)
> > +               __array(char, name, NAME_MAX + 1)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->order = order;
> > +               __entry->gfp_flags = (__force unsigned long)gfp_flags;
> > +               cgroup_name(memcg->css.cgroup,
> > +                       __entry->name,
> > +                       sizeof(__entry->name));
> > +       ),
> > +
> > +       TP_printk("memcg=%s order=%d gfp_flags=%s",
> > +               __entry->name,
> > +               __entry->order,
> > +               show_gfp_flags(__entry->gfp_flags))
> >  );
> 
> [...]

-- 
Thank you,
Dmitry

