Return-Path: <cgroups+bounces-885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C8807EED
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 03:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8BA1C21248
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7111847;
	Thu,  7 Dec 2023 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVF7+3/a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15994D63;
	Wed,  6 Dec 2023 18:45:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so138797b3a.1;
        Wed, 06 Dec 2023 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701917152; x=1702521952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eVcl2KDPJ4smMer/60vC6K9DZX/lHwn01b8AXePVZA=;
        b=WVF7+3/atU2PCmAv7Vc085uceTWQR7gSFRI70XASg0Igv6Pws9M74XKlX2omvLcfy2
         HJLk2LpLAGrJVPtkLZAGEDn7+4mQRMhLwDoL8hRUvHabaggDCuSObgDu/suYveG2OIER
         1vyzVTNLt0eolXdtL7VE9bj4yDRnSuRjZGKj+ukiUs6H7Rv3c+5iaeNxYSGUEjD1MckD
         Ha1g43CEoLnzwcf9QF8e/rMD6nIIP6z8GUk0izGPdWO2x6dD2GMWJvl43DM4i4YM7AIH
         vxlg4+buEddR5DTJX4o/KKLGpB8bnJrZD08cndQKi7TJ5vihQJH5/UnlKVxiOgJrF3yY
         C2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701917152; x=1702521952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eVcl2KDPJ4smMer/60vC6K9DZX/lHwn01b8AXePVZA=;
        b=qMBd+McGDdqViPJh8WCzoxGLHU46kBrJ45Y2BDUqjVuUIAn53HMCrxFD0TwVMw250H
         LZXlEP3BgxKYrlNQr+EuNhm0gMdbK/b5wZBGwv7HfzJAvCmi17KcuXPcQjDabu8NimKp
         gZAwcPRdWgF/8xCl0OegVkJXzBnDxAiXVhmz7BdEEh8bImd6Cw6JutNT6So5Wq//Gy9D
         k6MO+wZznDnU9B6EvRNSGQg/0SkJZnRfUXAB/j45ItsaiCDQnj8tTVugGT26dhLjGIzH
         /7ZmsRWonmHmycuohmPljDuVyXFupfMS3D72SVTQJTCZFjGWTa7zXBaTgL8XDTEbz33Y
         62fA==
X-Gm-Message-State: AOJu0YymiNViM6diiHMaDgyi+CLPJJPNzyBEAXuNPt/RQLn/gauvZaBV
	QlDFoBO79r12ivOvEIAclQs=
X-Google-Smtp-Source: AGHT+IH09WqraumX9Od5MBcINZWd36Ny5g3Mp4llOuonrFbnrJCx/jGfRW8jMrVLGD/L56O9ZZS5Qw==
X-Received: by 2002:a05:6a21:170f:b0:18f:9c4:d33c with SMTP id nv15-20020a056a21170f00b0018f09c4d33cmr4986434pzb.44.1701917152256;
        Wed, 06 Dec 2023 18:45:52 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id p24-20020a639518000000b005c676beba08sm177028pgd.65.2023.12.06.18.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:45:51 -0800 (PST)
Date: Thu, 7 Dec 2023 11:45:43 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 00/21] remove the SLAB allocator
Message-ID: <ZXEx1/p9ejRmkVTS@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:11PM +0100, Vlastimil Babka wrote:
> Changes from v1:
> - Added new Patch 01 to fix up kernel docs build (thanks Marco Elver)
> - Additional changes to Kconfig user visible texts in Patch 02 (thanks Kees
>   Cook)
> - Whitespace fixes and other fixups (thanks Kees)
> 
> The SLAB allocator has been deprecated since 6.5 and nobody has objected
> so far. As we agreed at LSF/MM, we should wait with the removal until
> the next LTS kernel is released. This is now determined to be 6.6, and
> we just missed 6.7, so now we can aim for 6.8 and start exposing the
> removal to linux-next during the 6.7 cycle. If nothing substantial pops
> up, will start including this in slab-next later this week.

I've been testing this for a few weeks on my testing system,
It passed a set of mm and slab tests on various SLUB configurations.

For the series, feel free to add:
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> To keep the series reasonably sized and not pull in people from other
> subsystems than mm and closely related ones, I didn't attempt to remove
> every trace of unnecessary reference to dead config options in external
> areas, nor in the defconfigs. Such cleanups can be sent to and handled
> by respective maintainers after this is merged.
> 
> Instead I have added some patches aimed to reap some immediate benefits
> of the removal, mainly by not having to split some fastpath code between
> slab_common.c and slub.c anymore. But that is also not an exhaustive
> effort and I expect more cleanups and optimizations will follow later.
> 
> Patch 09 updates CREDITS for the removed mm/slab.c. Please point out if
> I missed someone not yet credited.
> 
> Git version: https://git.kernel.org/vbabka/l/slab-remove-slab-v2r1

