Return-Path: <cgroups+bounces-10225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1CB82B3C
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E663B3242D9
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964A209F5A;
	Thu, 18 Sep 2025 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XSu9GkJl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6C3D984
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164612; cv=none; b=twGq+/+FawYfN2KypVv3cHFTkgooGFtckkX56qSD+ESb3AyIdbUgN5+424og+lzsVnApju93zXpz9FJfNKjPHlwgOe7S3Ij1R2y0nbU1f2T17FJ+G9R0bduuq1aTzkdw3NfZ24X4x0+XJBOkp5N+ZPit50HNcs93O/skOIs1MVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164612; c=relaxed/simple;
	bh=+sB+fiSv3TMnYhIPo1koOy8UW5O0w8HHQ+EPmd8qw+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru9zs30BYXLYJFz93OKSaTuHkj8oLyK1mJu3J/Ox29pXbU3wPyo//aiQs7lJuZbjtm7g6xYRJ1TJQCnzv0/dYgCyC9YOWoyHx9SDke4iZcAeMn49pjBcuzSXCjcaaLWoMxJMnZgNCWQsjSsnZ+PZ7iHRvZETbaAMViTofSsMamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XSu9GkJl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96c48e7101so419482276.2
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 20:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758164609; x=1758769409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHpj6BbDwwIXPitsNuyHsVAF3LXrP5LSMuZFLRbzGzk=;
        b=XSu9GkJlkkMKY1quv92NRsJCJv6Geq+ydFunN8dZundliou03JaOGLIlL/pVvXiV4G
         130PESoD11IosbtShQRzZczYln6nb5A3PoHY/MA+dWbf14cGr08Ol+gMJz9IcN+APeJx
         WK0HO7vP1eofhpx7juYpFo7YRIx+KD0hMrEwBs5vB1VZ2jlk5x8UqGAtgVlvOEXT1Zdl
         gZiVYme0QZUWOQjThEQd9mT1psOT6ZxLZidzT5JEv19k0e4oQHiq1oPr4y6I4lW+iMyE
         zPt7Yp1pGa0Qkbw/NnDfGrtijrzhr2Cv0Af4i5uXv7ZzAaBQ6ljBT2MROYP0srNC61l5
         4IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758164609; x=1758769409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHpj6BbDwwIXPitsNuyHsVAF3LXrP5LSMuZFLRbzGzk=;
        b=UW+bS1ph9LbFfkkNxuN/vNm/Ik9SmqseSKEQWO2eB52mK5YEEwTIW6wK3nPYLFFQns
         E6lhXEFQ3Tfk2aEM1Rxk2F9z5ZzU3BuOiK3oVoT5esv8OIrU1V+XUmh/06m6RNngCRMi
         japKlT+BvGYyc2PWOXYGE/PtQe5UU2peFRu9qMG0ZnBVImsjnEvYGiieuMiTbJfC/G1z
         4SaGBm7SsFsM3w+EDx1GlczIquPEnmZ+7yIdaCalZd0TGBeMF4M3fzT/iXwrvvvyVwEC
         0YFSpP5aIH28GHa41MAssf8loBqoiIgPqvv2eQe8PpOcTB3yp1OWbSg0Al4oIb36eD6P
         y+Jg==
X-Gm-Message-State: AOJu0Yx0e8qj6IJgs35RjOJy5K/4wGBnXMwYISus3lKpN/srV5WiE8do
	DovrHdVUg6rlWAQIvRYH9T+ioVNhb8BWuJicY0jLGGcBumkMTH4ug2sKhT3i94O368jL1FdzMeG
	YlMY4d9f8yNbUona4zxpNMxClTBXqz95oF9p01bU1wA==
X-Gm-Gg: ASbGnct6dLOh6El2IwYT20uqNMmbb6oDF5O9uks0fyu9enR1sqQ7aDzfYSS6KxKzp5K
	tBX7jI0eysCzOHf1CJUDVUh/ZDR5JiSygJGJ3q/2cvoj7NTH3YIc/mVjfVz5h7A+EKBeekYVCyB
	lkhHTWoG5mI+56MUVpLLuwNRaz0m1ltdAN+62IC6QJFpHhiWp9iYOh2S/8k1WQ4pPCBDE9Gd+W/
	tbCetcWb9gzvIm9jGrwG/ZKNiA1q6feiy0Dz/JjTys0gw==
X-Google-Smtp-Source: AGHT+IHCITpJmu2ecNbyMYkgBdyARFalcZTQ2c76f039ZpJlRRLWnUY1w7SMwkwh0HFxl5emiWnN3oHg/pKKMvzfi+s=
X-Received: by 2002:a05:690c:4d89:b0:723:9d84:4e5a with SMTP id
 00721157ae682-7389159bd76mr40982237b3.23.1758164609176; Wed, 17 Sep 2025
 20:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917212959.355656-1-sunjunchao@bytedance.com> <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
In-Reply-To: <20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 18 Sep 2025 11:03:18 +0800
X-Gm-Features: AS18NWDNMpykuZ-ToHyptz7SoNhYLyL8Wo4PLyJsFMUV3bdV3cR6VduCnMFfMAQ
Message-ID: <CAHSKhtdt9n-K6KGXTwofpRPo-pH0-YoKFLtEe3Z4CszmNL0rCg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] memcg: Don't wait writeback completion
 when release memcg.
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, tj@kernel.org, 
	muchun.song@linux.dev, venkat88@linux.ibm.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for your review and comments.

On Thu, Sep 18, 2025 at 6:22=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 18 Sep 2025 05:29:59 +0800 Julian Sun <sunjunchao@bytedance.com> =
wrote:
>
> > Recently, we encountered the following hung task:
> >
> > INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
> > [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
> >
> > ...
> >
> > The direct cause is that memcg spends a long time waiting for dirty pag=
e
> > writeback of foreign memcgs during release.
> >
> > The root causes are:
> >     a. The wb may have multiple writeback tasks, containing millions
> >        of dirty pages, as shown below:
> >
> > >>> for work in list_for_each_entry("struct wb_writeback_work", \
> >                                   wb.work_list.address_of_(), "list"):
> > ...     print(work.nr_pages, work.reason, hex(work))
> > ...
> > 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
> > 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
> >
> > ...
> >
>
> I don't think it's particularly harmful that a dedicated worker thread
> has to wait for a long time in this fashion.  It doesn't have anything
> else to do (does it?) and a blocked kernel thread is cheap.

It also delays the release of other resources and the update of
vmstats and vmevents statistics for the parent cgroup. But we can put
the wb_wait_for_completion() after the release of these resources.
>
> > 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
> > 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
> >
> >     b. The writeback might severely throttled by wbt, with a speed
> >        possibly less than 100kb/s, leading to a very long writeback tim=
e.
> >
> > ...
> >
> >  include/linux/memcontrol.h | 14 +++++++++-
> >  mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
> >  2 files changed, 62 insertions(+), 9 deletions(-)
>
> Seems we're adding a bunch of tricky code to fix a non-problem which
> the hung-task detector undesirably reports.

Emm.. What is the definition of 'undesirably' here?
>
> Would a better fix be to simply suppress the warning?
>
> I don't think we presently have a touch_hung_task_detector() (do we?)
> but it's presumably pretty simple.  And maybe
> touch_softlockup_watchdog) should be taught to call that
> touch_hung_task_dectector().
>
> Another approach might be to set some flag in the task_struct
> instructing the hung task detector to ignore this thread.

To me, this feels kind of like a workaround rather than a real fix.
And these approaches are beyond the scope of memcg, I'm not sure how
Tejun thinks about it since he mentioned before wanting to keep the
modifications inside the memcg. Given the fact we already have an
existing solution and code, and the scope of impact is confined to
memcg, I prefer to use the existing solution.
>
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

