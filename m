Return-Path: <cgroups+bounces-749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0317FFDFF
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819FD1F20F73
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83A5B5A8;
	Thu, 30 Nov 2023 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tepH5Wb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94C10F8
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 13:52:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc79f73e58so17525ad.1
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701381158; x=1701985958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfe9+yUHQWvFF1MBxcyQEWLBB5xhP4R/v24MyHrer70=;
        b=0tepH5WbTQDmSBXXhFxxics+9wndxDVEo7hFze81ihmWMaiRmp5254VIEOZUvOB2wy
         63Qz9piC+Lk2GItfcKvudo3r8eRj/CzXqt8K9Bk6YQ0RML4NkmI1AQkplvtJPgklBcRq
         7bygYxKAHNltIvNwgTw4FbmO9w4OBnv30ciCcl+Ebin1e9u+XaLmOB+rsUtPWfP/IpA5
         KMO2KVrbWJY41zRN39DEthXOHRp1HyBD1jTFnbCrOL//YsRXNnejbq3Rz8Rw5JQYm1Ap
         AW7V/g7UvGAeGTm6zPCqE1aMbQl1mTHDiCRmHQ3gKSeM1EX0nLOAkKSmvHeY6v/8yTKB
         EpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381158; x=1701985958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfe9+yUHQWvFF1MBxcyQEWLBB5xhP4R/v24MyHrer70=;
        b=g6v2QyhO3UkMpUBPS7AUETzyScxK/k2Yi3dUVnyPS2Gg1w+vOk2YMI5pKCZmhTwJsT
         31KnQEsEu8GQpmR/eYOFibIsSwlpMVcyPd9TgnUezVHSAeRxozoMFLnRXu2itJOPtsNu
         HcrJCW0SJ4Mrho40/kkSym5eeerAXg80DeacGzeDG6hUZHOo6cqRaL1C1dCYdsPTmjbo
         sS9c3hZwIHNXqBF7rqlBCyJ4ryFBkrsSEIkCE4qP+C1QxgYC/BZ8PnsH1WdhV3GwKFoj
         RPT9qJfr6ZOJx0NZBVwj8vxArLLCqfjlHt6JOF5Z+mp5k+DNNaLwALOVMV3Xt1blfsTE
         j8ag==
X-Gm-Message-State: AOJu0YxFWgAw7V+QzDp/TFlci/Aj13gcffAoll1XlDI2004Qouqeiaub
	bqEoJdPxGZ5ZWDY/fQVeMaEgfmfdaHDeQ/NIlpn0Vw==
X-Google-Smtp-Source: AGHT+IEScePdJsCv50KSaFJEK6pXwpZ9MhWwQ6fW0VE537kDsUCVBfYIWXio57IpD3sjKnP6BGpD7VHJg69DMzuDouE=
X-Received: by 2002:a17:902:b684:b0:1cf:b218:25c7 with SMTP id
 c4-20020a170902b68400b001cfb21825c7mr39731pls.0.1701381157613; Thu, 30 Nov
 2023 13:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka> <20231130165642.GA386439@cmpxchg.org>
 <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV> <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
 <ZWkAiZ+Wx6VwRAPu@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZWkAiZ+Wx6VwRAPu@dschatzberg-fedora-PF3DHTBV>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 30 Nov 2023 13:52:26 -0800
Message-ID: <CALvZod7Buc1TPXFDA2fE8+apE9VJDA=uAYB1u00kyZy9oLbmgA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 1:37=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Thu, Nov 30, 2023 at 12:30:27PM -0800, Shakeel Butt wrote:
> > On Thu, Nov 30, 2023 at 11:47=E2=80=AFAM Dan Schatzberg
> > <schatzberg.dan@gmail.com> wrote:
> > >
> > > On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> > > > [...]
> > > > So I wouldn't say it's merely a reclaim hint. It controls a very
> > > > concrete and influential factor in VM decision making. And since th=
e
> > > > global swappiness is long-established ABI, I don't expect its meani=
ng
> > > > to change significantly any time soon.
> > >
> > > I want to add to this last point. While swappiness does not have
> > > terribly well-defined semantics - it is the (only?) existing mechanis=
m
> > > to control balance between anon and file reclaim. I'm merely
> > > advocating for the ability to adjust swappiness during proactive
> > > reclaim separately from reactive reclaim. To what degree the behavior
> > > and semantics of swappiness change is a bit orthogonal here.
> >
> > Let me ask my question in this chain as it might have been missed:
> >
> > Whatever the semantics of swappiness are (including the edge cases
> > like no swap, file_is_tiny, trim cache), should the reclaim code treat
> > the global swappiness and user-provided swappiness differently?
>
> I can't think of any reason why we would want swappiness interpreted
> differently if it's provided at proactive reclaim time vs
> globally. Did you have something in mind here?

Nah just wanted to know what you are aiming for.

