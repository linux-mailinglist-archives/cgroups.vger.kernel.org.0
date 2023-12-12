Return-Path: <cgroups+bounces-926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EC80F99C
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B00D1F2174F
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2664148;
	Tue, 12 Dec 2023 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFTB2Hcd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3AAAB;
	Tue, 12 Dec 2023 13:43:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3278143a12.3;
        Tue, 12 Dec 2023 13:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702417432; x=1703022232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYFGcvpC2a9QSpzB8tRAV/ZTOG8iYLcCMIlAxh09bmk=;
        b=SFTB2Hcd4DX6QFV5OwJngSJA4yTgce33EDXqcUzDogJ3DLCI8yQXQcB3axppwVl4g5
         ELf1KTY6wtm1W17rSOOwVU4S3XY40c2UC7uV/bDGWFE2WyS+EkS76kOWMvjPlGaerJTt
         rjSSlKN+8HfZ8aa5GyiQ3jI+ws59OroILyJumJw2UBXZgP4NObJmRCVqWfiJpsB8ourT
         5YZWJiU4ZC1g5DUZBd9zGBs+Yq3nXyaKJQdXxVKJPYgvAWq1gFqV56rSI/OZlc00iuTv
         5ghqfzwZnbOqQ830Pwd92jh8NOpaGEPTA/GeTjblmPLImpwVgA1VCGaT3JJlFwr1hs/8
         ZDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417432; x=1703022232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYFGcvpC2a9QSpzB8tRAV/ZTOG8iYLcCMIlAxh09bmk=;
        b=Xq1NgLcrlU+nfk/ujEZ6Hz2Ihqz/PCynpSDT0DCqZeoFO6Zbv2cOOyuceOiS4tscQV
         hhJ5Y7VORGgLDJzoO762baZ4PpTQ8gQ1aCwvfan7d06EyZiX0iIwZcJyPChs08RlS2Z0
         TKIG0sO/hNHgvs0Zve2dg/A1/l+4PSx7pf7TqB/F6p6Tychga/KCGuMZcOE9dJsy9kWa
         dTIObE7nD0d4AtL4VBsfgihOl3Gj3DzGU2WkE0Bnjn3Zdh+iCjnAUDJCoyB1pdzap62o
         hSbxNdMR0Y95QlokkX1vsTxMcJoQjCgTwwLxkPq44cLY2/nh0h++j2PkDJMKRi/pqOfE
         SZ3Q==
X-Gm-Message-State: AOJu0Yw2cYXAPrURtWiuPOPS/6ObYtoK7ACwrXRTT3QTqennkSMmcmpW
	4/IQwrAvy4b41Hr/Ju8tt7c=
X-Google-Smtp-Source: AGHT+IEDWWFSu/2HO7omc9rG7/wpgLn5lEP9tPOE8jeGHF9ecMnMo2w9mQ+i6UiCvYTNQM2v7hVLxA==
X-Received: by 2002:a17:902:ab45:b0:1d3:46f6:8046 with SMTP id ij5-20020a170902ab4500b001d346f68046mr743839plb.27.1702417431594;
        Tue, 12 Dec 2023 13:43:51 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:671e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9024911plr.121.2023.12.12.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:43:51 -0800 (PST)
Date: Tue, 12 Dec 2023 16:43:48 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXjUFMwlz3P+4Nmk@dschatzberg-fedora-PF3DHTBV>
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com>
 <CAF8kJuOhwjZZWab1poi1rPiV4u8O1CEZSO0cO23+aewt6S74-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuOhwjZZWab1poi1rPiV4u8O1CEZSO0cO23+aewt6S74-g@mail.gmail.com>

On Mon, Dec 11, 2023 at 05:06:54PM -0800, Chris Li wrote:
> Hi Dan,
> 
> Thank you for the patch.
> 
> On Mon, Dec 11, 2023 at 6:04 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > Allow proactive reclaimers to submit an additional swappiness=<val>
> > argument to memory.reclaim. This overrides the global or per-memcg
> > swappiness setting for that reclaim attempt.
> 
> I am curious what prompted you to develop this patch. I understand
> what this patch does, just want to know more of your background story
> why this is needed.

I wrote about this in some detail in the cover letter (0/1). Take a
look and let me know if the rationale is still unclear.

> Instead of passing -1, maybe we can use mem_cgroup_swappiness(memcg);
>

Yeah this makes sense, I'll go ahead and make that change and
eliminate the -1.

> >                                 nr_reclaims--;
> >                         continue;
> >                 }
> > @@ -6895,6 +6896,16 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> >         return nbytes;
> >  }
> >
> > +enum {
> > +       MEMORY_RECLAIM_SWAPPINESS = 0,
> > +       MEMORY_RECLAIM_NULL,
> > +};
> > +
> > +static const match_table_t if_tokens = {
> 
> What this is called "if_tokens"? I am trying to figure out what "if" refers to.

I used the same logic as in "mm: Add nodes= arg to memory.reclaim". I
can just call it tokens.

> 
> > +       { MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
> > +       { MEMORY_RECLAIM_NULL, NULL },
> > +};
> > +
> 
> Do we foresee a lot of tunable for the try to free page? I see. You
> want to use match_token() to do the keyword parsing.

See below

> 
> >  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> >                               size_t nbytes, loff_t off)
> >  {
> > @@ -6902,12 +6913,33 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> >         unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> >         unsigned long nr_to_reclaim, nr_reclaimed = 0;
> >         unsigned int reclaim_options;
> > -       int err;
> > +       char *old_buf, *start;
> > +       substring_t args[MAX_OPT_ARGS];
> > +       int swappiness = -1;
> >
> >         buf = strstrip(buf);
> > -       err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > -       if (err)
> > -               return err;
> > +
> > +       old_buf = buf;
> > +       nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
> > +       if (buf == old_buf)
> > +               return -EINVAL;
> > +
> > +       buf = strstrip(buf);
> > +
> > +       while ((start = strsep(&buf, " ")) != NULL) {
> > +               if (!strlen(start))
> > +                       continue;
> > +               switch (match_token(start, if_tokens, args)) {
> > +               case MEMORY_RECLAIM_SWAPPINESS:
> > +                       if (match_int(&args[0], &swappiness))
> > +                               return -EINVAL;
> > +                       if (swappiness < 0 || swappiness > 200)
> 
> Agree with Yosry on the 200 magic value.
> 
> I am also wondering if there is an easier way to just parse one
> keyword. Will using strcmp("swappiness=") be a bad idea? I haven't
> tried it myself though.

As above, "mm: Add nodes= arg to memory.reclaim" was previously in the
mm tree doing it this way, so I duplicated it. I think given that
there have been lots of discussions about extending this interface,
this match table has some potential future value and I don't see a
major downside to using it in favor of strcmp.

