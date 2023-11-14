Return-Path: <cgroups+bounces-385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83D7EA993
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272851C20A16
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774671857;
	Tue, 14 Nov 2023 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCjAYxdq"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD6BA2D
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:34:33 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E291D49
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:34:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4442804b3a.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936472; x=1700541272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o11HARQxoCvg8Gx5zjjgZkRsPvVu73rMm7hpUxapQ0A=;
        b=nCjAYxdqkxTcu4IH1X2BoihM3eISHye9R89txlKCrNR1Z21wy+2EWieTDV8Lt7FRcc
         8oDzGftIS6Xl+kf3lbraPK9h5hHKtFVG5zLOqK9qvFklCKwOR9twagX5h7dtuDQ4e+TH
         RHbCs7s5CBh9e8cJAp2tnrrOlRwc8lEfqZwBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936472; x=1700541272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o11HARQxoCvg8Gx5zjjgZkRsPvVu73rMm7hpUxapQ0A=;
        b=pQDC+TWWm+iLpb3gXtrUc127bict/VJ4B1MksX6lzKOlXPyWCGdBEkg4TvYrwVui2u
         5ZNM4mWs89DfpHq9HvUNJ1qL/qJdXoCK+7v2dgGsKm/Jnc4XwG+wZe04qBm8aIZl3NYv
         8XugPcLxAA4UTCQ40fs65vBiD7B8ZxubaFE+g/W/Xxh45Id0ObIQm3xfDj8pHrpBIjks
         kSlfdBxzr4D1KF+SsTzB7qfcWQmIbCJYrY6LUqfBJ9K3jn76p+xKtcli9fx+3HFHxCBd
         Z0DA+9rPgXPC0/gbwEzbwNMQd17KX59paN09kjowXr/Zp0wRjsE9rZX0SUuSt9IQiHi4
         PFyw==
X-Gm-Message-State: AOJu0YyI4vuvmtzKLRg7LKPJK9bmBIxGCj9xfSzMpC+Auli8h8+QORFx
	D/eFXVFGphwoj18/GNGoPw/qfQ==
X-Google-Smtp-Source: AGHT+IGseueIFF+JmLoGhwnqLpZw2W4u0dwVJZMG/dnzFetGq2hz6yOEFr5CcVgcKPJNd+w2yidtYw==
X-Received: by 2002:a05:6a20:729e:b0:186:7ac3:41c8 with SMTP id o30-20020a056a20729e00b001867ac341c8mr4469072pzk.56.1699936472009;
        Mon, 13 Nov 2023 20:34:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c465bedaccsm4835731pls.83.2023.11.13.20.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:34:31 -0800 (PST)
Date: Mon, 13 Nov 2023 20:34:31 -0800
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
	cgroups@vger.kernel.org, Mark Hemment <markhe@nextd.demon.co.uk>
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
Message-ID: <202311132032.1BB9A17@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-30-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-30-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:49PM +0100, Vlastimil Babka wrote:
> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
> properly).
> 
> RIP SLAB allocator (1996 - 2024)

/me does math on -rc schedule... Yeah, okay, next merge window likely
opens Jan 1st. So, this will land in 2024. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

