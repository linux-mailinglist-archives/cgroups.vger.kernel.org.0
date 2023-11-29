Return-Path: <cgroups+bounces-684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF37FDE78
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F842824C1
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AE4B5BA;
	Wed, 29 Nov 2023 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5713ADC;
	Wed, 29 Nov 2023 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D526C433C7;
	Wed, 29 Nov 2023 17:34:23 +0000 (UTC)
Date: Wed, 29 Nov 2023 12:34:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, akpm@linux-foundation.org,
 mhiramat@kernel.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, kernel@sberdevices.ru,
 rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129123446.7d41c4e9@gandalf.local.home>
In-Reply-To: <ZWdwifakPuMZbFUV@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
	<20231123193937.11628-3-ddrokosov@salutedevices.com>
	<ZWRifQgRR0570oDY@tiehlicka>
	<20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
	<ZWSQji7UDSYa1m5M@tiehlicka>
	<20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
	<ZWWzwhWnW1_iX0FP@tiehlicka>
	<20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
	<ZWdhjYPjbsoUE_mI@tiehlicka>
	<20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
	<ZWdwifakPuMZbFUV@tiehlicka>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 18:10:33 +0100
Michal Hocko <mhocko@suse.com> wrote:

> > > How? You are only reporting the number of reclaimed pages and no
> > > reclaimed pages could be not just because of low/min limits but
> > > generally because of other reasons. You would need to report also the
> > > number of scanned/isolated pages.
> > >    
> > 
> > From my perspective, if memory control group (memcg) protection
> > restrictions occur, we can identify them by the absence of the end()
> > pair of begin(). Other reasons will have both tracepoints raised.  
> 
> That is not really great way to detect that TBH. Trace events could be
> lost and then you simply do not know what has happened.

Note, you can detect dropped events. If there's a dropped event, you can
ignore the "missing end" from a beginning. You could also make synthetic
events that pair an end event with a beginning event (which uses the last
begin event found). Synthetic event creation is not affected by dropped
events.

There's a lot you can to get information with the prospect of dropped
events. I would not use that as rationale for not using events.

-- Steve

