Return-Path: <cgroups+bounces-738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA07FFC7C
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1537281A33
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D254FBD;
	Thu, 30 Nov 2023 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4y9otrl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA01703
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d0477a0062so37015ad.0
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701376239; x=1701981039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0GgAeTxou/WviiWghWlEQir3U8XoSLtDVw1f4rh7wk=;
        b=d4y9otrl3zoLccFUcDL6v7kOBnO5McfWqkdXQPXOZ6vu3Xh4oVh45HWVLekuY3EQUY
         jfQZPPTIb84AQBJHnPjwPHXZ4JFkqU64LexPu2NrdBFFdNbekOk6FBafFSjTtLWOJV6c
         V/u4Nph88NrnGUWxfjUzq/Fc1g50RUalOGiF8YloSSdeXEROClRsy3Ht5SKW4dr5lWjv
         lV7wRN4C7ale8qvvniBgqtLZt1FUDfgbDKH1Tw5aEjK4TqSxfrtlt5bUJJBJcik+X1wb
         Y2slW3GeHDD+zv1P9KUsIF0CA++aSwH9Fs7Qwh74vStWp56Dr+aLWkQdXzDGwVEyr59+
         UUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376239; x=1701981039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0GgAeTxou/WviiWghWlEQir3U8XoSLtDVw1f4rh7wk=;
        b=AguqlYGkrty9DbRoZGD+cgys9yexnCwuItHfGP6nUBLhcXScLyoklFnwn5dqGI250R
         CpgxXFn2y3KG9eb3yO2kyC2ZXmYqLDlA0r5bOq0xRIqRdkb0xBILkUr+KBjdBexY5FNr
         3kx4D9ylyIy4HjvKk+Eh5AOXedB7So2spHsyKYz/7oPsf22p9ALwjarkvAEMtb3inO8+
         ezmJ0jzOIAeYTVmvkd9qUWHbyBISQ1fvLMCz+G1x01beSjHWSxeSwga7lYcPCcuGKDdQ
         YUOs75j+/MEMX2cKuFy1yoGuT9D3ci8x1EL9DDDrXVkx9GKlv71UsKkFOGjcG8wso101
         XsiA==
X-Gm-Message-State: AOJu0Yw2Yk1zjbKZzyyJ1lX6DGdY9ecZ0sLqNpJapxy/3VqN27WfWBUM
	6llFbUhIIEjn1rktiG5W4qoVEOwhRTX6cZfizpL4Ng==
X-Google-Smtp-Source: AGHT+IFALleiRKpy4be/3B0fJjnqsRAMk9mHiJRVXRJ1MUw9jngX/21Z5USdXgeYBJ7HRdM1SRQ30MFo8J0rdQZhK98=
X-Received: by 2002:a17:902:e812:b0:1c7:25e4:a9d5 with SMTP id
 u18-20020a170902e81200b001c725e4a9d5mr4421plg.17.1701376239428; Thu, 30 Nov
 2023 12:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka> <20231130165642.GA386439@cmpxchg.org> <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 30 Nov 2023 12:30:27 -0800
Message-ID: <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
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

On Thu, Nov 30, 2023 at 11:47=E2=80=AFAM Dan Schatzberg
<schatzberg.dan@gmail.com> wrote:
>
> On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> > [...]
> > So I wouldn't say it's merely a reclaim hint. It controls a very
> > concrete and influential factor in VM decision making. And since the
> > global swappiness is long-established ABI, I don't expect its meaning
> > to change significantly any time soon.
>
> I want to add to this last point. While swappiness does not have
> terribly well-defined semantics - it is the (only?) existing mechanism
> to control balance between anon and file reclaim. I'm merely
> advocating for the ability to adjust swappiness during proactive
> reclaim separately from reactive reclaim. To what degree the behavior
> and semantics of swappiness change is a bit orthogonal here.

Let me ask my question in this chain as it might have been missed:

Whatever the semantics of swappiness are (including the edge cases
like no swap, file_is_tiny, trim cache), should the reclaim code treat
the global swappiness and user-provided swappiness differently?

