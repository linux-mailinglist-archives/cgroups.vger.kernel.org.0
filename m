Return-Path: <cgroups+bounces-387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272E7EA9A7
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA63B20A22
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94CC5688;
	Tue, 14 Nov 2023 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TuH8e6qV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787F8827
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:38:27 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D37198
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:38:26 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-586ad15f9aaso2668754eaf.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936706; x=1700541506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKLnTTpcsA4GTSpHutPlS9fMo+BLZ8ixEQsC9MUWwLk=;
        b=TuH8e6qV6/EInFoxz1miaeAAFEsLBTtYoGEKOPWYhyQiXnCiTAuD13eGSaSddQ8S9o
         2fBovA96XFn/wl5qu4/72ZzmLXdorvOvPOSScrNlRfASL8q7kBZBaq16aZMjCb1yV6PN
         ENBos8u15PIVTUeCRkLyVcIYsPQvgCT/i+3dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936706; x=1700541506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKLnTTpcsA4GTSpHutPlS9fMo+BLZ8ixEQsC9MUWwLk=;
        b=uwULxKJgA5L8fwngBz6eeKZD3ExA3ZIyy1428VMXYo9fC7I+VQKedtWwK/Zu7y4ofk
         F0QTWRmhkmhGLRsOPl5gXdxz+2TJM4gGKMs5Gjx9LY7iswcV/kuXeHdN4N7c05+u0tY/
         ZppUe4RExdWiOZ0TxAzk+PFlcVJSNT3TSOqckyDsO7UO4hCwbPJMKtcJNPsvXqpHEMYY
         E1h+z7g3ukpGePRC1cKvM5s3f4F3BYmecKfF91uoNY8EQrvSvIJff68LhiU2w70nkZkJ
         vJDXQXqtw3/YtaIQjtpWAPgpUymffhnmrn44cQipdwlsNOtj7w43ON2UBjP6gzCV7p0J
         w5gg==
X-Gm-Message-State: AOJu0Yw2hs0/0xNqQvj0SthUtLdNbePTN65KUCvQXOZ9GwprGx6s5Qpf
	BSXr8/dBQALsqCGwPwVpr+alGw==
X-Google-Smtp-Source: AGHT+IFDSeKpFIR7EqfcNMWsaO6kBeTgiI6AAPV/dcvwqXilQHmw3/CSiZnWYA9Y/YDdW/YrAaS6hg==
X-Received: by 2002:a05:6358:914:b0:168:eded:d6c9 with SMTP id r20-20020a056358091400b00168ededd6c9mr1639355rwi.29.1699936705986;
        Mon, 13 Nov 2023 20:38:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020a63e20e000000b0056946623d7esm4832935pgh.55.2023.11.13.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:38:25 -0800 (PST)
Date: Mon, 13 Nov 2023 20:38:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 10/20] mm/slab: move the rest of slub_def.h to mm/slab.h
Message-ID: <202311132037.F4FA0B2@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-32-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-32-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:51PM +0100, Vlastimil Babka wrote:
> mm/slab.h is the only place to include include/linux/slub_def.h which
> has allowed switching between SLAB and SLUB. Now we can simply move the
> contents over and remove slub_def.h.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Now is the chance to do any whitespace updates! I saw a few #defines
that looked like they could be re-tab-aligned, but it's not a big deal. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

