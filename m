Return-Path: <cgroups+bounces-927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCF80F9A8
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22001B20EAD
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF564155;
	Tue, 12 Dec 2023 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbeXzqgg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC7D0;
	Tue, 12 Dec 2023 13:46:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d098b87eeeso55250515ad.0;
        Tue, 12 Dec 2023 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702417567; x=1703022367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kNbvUbgD/ga0q6vHooPK3cYbAsvMu2YMiNOPyF47Oz8=;
        b=hbeXzqgguguMp19EoPmHlZuoUWOhS64EC+EJn31ZTZfTVk6a0+4Ey5VkR9HloGfwI5
         8Fl05bqCbEyUKYpXYHmPqt7krTbiKRah6smQiEyZabrdb3ExlzT4ewsdvJAUpSAJ+GhE
         QjqF73E+Q0VXoJ2ZmirD3awhKk5Tc9FUOD0sVmNkec4Vr4O8GVYFxhSd3axJOIGLuxyT
         Itow6gY1LnScY6Md5OUK0+KyAS8AKbaddzFVaMdjFsnIzR7JSIF6ZJqFwesX0ISNVkQ1
         DNF/+s8ZTSSz6z88MEt2aSgUYQ/CRdxGB2OA4gTVLqeb39gZkBeNmluoie6cNnDJZbyb
         9bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417567; x=1703022367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNbvUbgD/ga0q6vHooPK3cYbAsvMu2YMiNOPyF47Oz8=;
        b=Lf/jb3dFfvSLoh8bFpu/3hC5D+fnbn1FZjWawEsBejdGW3W3qeV3vPc50fqQ0RNygi
         ZLV+UCYCT181tNji6Apx6zP9tcpSjrNcgDaV4jVInpMEJF0IO3lsIj4Pml3TzKT5dYsz
         c2YFmMr+EVv9pcDIXwpbNhNG3imvpWjyvIkPjfxpjpLdwdialZeQ3d37MdSXpFhyZfb3
         mNOKzcQHlmKB2Ge+a9ckrmSRYCnGDC/7ERuQQG/2XSBE1foHnsNdWTV5H+X1fqPH14xH
         zWes4MnGM8sIQcFS+Z0Ip0ZHJBb9r1fScHSofcQU1dEOsT1xax5XCu/9/43TJ0hIfWij
         GRoA==
X-Gm-Message-State: AOJu0Ywp9B891DJiNn4ZZqgk/IcwtH944F4yIDUuOVUeOegIpMblslha
	vAsJAcry9V9ylXHsJ3RfCsQ=
X-Google-Smtp-Source: AGHT+IHxpa4QDsQ3wjeymvm0sshjoWSkDipvsjqlYvllXHnWwoJ6JpH93+nCSvAYMglDwVam0K9f6w==
X-Received: by 2002:a17:902:7e8c:b0:1d0:5ad7:54f8 with SMTP id z12-20020a1709027e8c00b001d05ad754f8mr5632677pla.15.1702417567506;
        Tue, 12 Dec 2023 13:46:07 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:671e])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001cfa4178981sm8971631plb.309.2023.12.12.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:46:06 -0800 (PST)
Date: Tue, 12 Dec 2023 16:46:03 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXjUm9n4qwtWNdHq@dschatzberg-fedora-PF3DHTBV>
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com>
 <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
 <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
 <CAJD7tkY6iTxKe4Nj00sN3vh26Cw2Sw+kTkY40r000+ttN-dFpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY6iTxKe4Nj00sN3vh26Cw2Sw+kTkY40r000+ttN-dFpg@mail.gmail.com>

On Tue, Dec 12, 2023 at 01:31:46PM -0800, Yosry Ahmed wrote:
> On Tue, Dec 12, 2023 at 1:27 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 11:41:24AM -0800, Yosry Ahmed wrote:
> > > On Mon, Dec 11, 2023 at 6:04 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > contains* the*
> > >
> > > I think this statement was only important because no keys were
> > > supported, so I think we can remove it completely and rely on
> > > documenting the supported keys below like other interfaces, see my
> > > next comment.
> > >
> > > > +       to reclaim.
> > > >
> > > >         Example::
> > > >
> > > > @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
> > > >         This means that the networking layer will not adapt based on
> > > >         reclaim induced by memory.reclaim.
> > > >
> > > > +       This file also allows the user to specify the swappiness value
> > > > +       to be used for the reclaim. For example:
> > > > +
> > > > +         echo "1G swappiness=60" > memory.reclaim
> > > > +
> > > > +       The above instructs the kernel to perform the reclaim with
> > > > +       a swappiness value of 60. Note that this has the same semantics
> > > > +       as the vm.swappiness sysctl - it sets the relative IO cost of
> > > > +       reclaiming anon vs file memory but does not allow for reclaiming
> > > > +       specific amounts of anon or file memory.
> > > > +
> > >
> > > Can we instead follow the same format used by other nested-keyed files
> > > (e.g. io.max)? This usually involves a table of supported keys and
> > > such.
> >
> > Thanks, both are good suggestions. Will address these.
> >
> > > > +       while ((start = strsep(&buf, " ")) != NULL) {
> > > > +               if (!strlen(start))
> > > > +                       continue;
> > > > +               switch (match_token(start, if_tokens, args)) {
> > > > +               case MEMORY_RECLAIM_SWAPPINESS:
> > > > +                       if (match_int(&args[0], &swappiness))
> > > > +                               return -EINVAL;
> > > > +                       if (swappiness < 0 || swappiness > 200)
> > >
> > > I am not a fan of extending the hardcoded 0 and 200 values, and now
> > > the new -1 value. Maybe it's time to create constants for the min and
> > > max swappiness values instead of hardcoding them everywhere? This can
> > > be a separate preparatory patch. Then, -1 (or any invalid value) can
> > > also be added as a constant with a useful name, instead of passing -1
> > > to all other callers.
> > >
> > > This should make the code a little bit more readable and easier to extend.
> >
> > I'm not sure I understand the concern. This check just validates that
> > the swappiness value inputted is between 0 and 200 (inclusive)
> > otherwise the interface returns -EINVAL. Are you just concerned that
> > these constants are not named explicitly so they can be reused
> > elsewhere in the code?
> 
> Yes. The 0 and 200 values are already hardcoded in multiple places,
> and we are adding more places now and more hardcoded values (i.e. -1).

Understood, I'll add a preparatory patch which adds DEFINEs for
MIN_SWAPPINESS and MAX_SWAPPINESS and change the usages of 0 and 200
to those. I'll also eliminate the use of -1 as Chris suggested.

