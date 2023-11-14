Return-Path: <cgroups+bounces-392-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F967EA9C1
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B7F281087
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908218F51;
	Tue, 14 Nov 2023 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OSi1MVa9"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050E8F55
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:45:50 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA1125
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:45:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc316ccc38so39848155ad.1
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937149; x=1700541949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBMZCd1RTYcku4fr+eS/5T5vGEq4PYQLNXmfcgCc7wA=;
        b=OSi1MVa9q3OgTaatfrhWgq/PWqv3k2u+7sJbNRozGNotiSRIjT8JjyIkpLzed6imT+
         MmokGqjCFRSRT+DHxPHepyFG4zYFCeBh6XldHC0E8p4oaKQLv6fr86rkI+L3hhEy+4XP
         aE6a31r/1X/0AZO79uagGZoBOFCGa4v/JKFY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937149; x=1700541949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBMZCd1RTYcku4fr+eS/5T5vGEq4PYQLNXmfcgCc7wA=;
        b=fU352rTAvH6CqeuCFZA5Io7cibOTN8Zp3D7jZ0W225E2MoC2BCug8AbMIrNdnEgSp7
         kynm7Gsi3n5X1aM5ymDaUJPlJhKMrM4Vbyh3PTTqjEYrj/WRs5Ridak/k691kLSiL0g0
         j09f6EdV865Jsc1++xHrjNvFPrZMxNhCNRw728NntHHAG5413LF8JkLI8QV9YYjePbQq
         naeDdm6SUbrVpKxKYmceDG0GIPNjtsChxZoqggMm+dOP2TR2f7gvqhafUkn+b55LtIaW
         pR4VOtNxIK879NnHc4cN7C9pYwj4aEIXNBxK5yZNYohp4c0/xvM9zo659q7f5tUIFtNK
         IBIw==
X-Gm-Message-State: AOJu0Yzasd/pFGDgs+F2eaZJb+wrmf64ziL4YO/nNltqRYPfvTeEAt6x
	BqLqDO5qDMc4aAwi9b/Qc+3txA==
X-Google-Smtp-Source: AGHT+IEsjAp3cBiJSP3PyvVvmPuSm+aeTJB4FD5LC9ruHOoqYzxrBqIrhGMYXmyQPi4w72yy/WPkjg==
X-Received: by 2002:a17:902:8542:b0:1c3:1f0c:fb82 with SMTP id d2-20020a170902854200b001c31f0cfb82mr968412plo.41.1699937148885;
        Mon, 13 Nov 2023 20:45:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001c55e13bf2asm4804097plr.283.2023.11.13.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:45:48 -0800 (PST)
Date: Mon, 13 Nov 2023 20:45:48 -0800
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
Subject: Re: [PATCH 15/20] mm/slab: move kfree() from slab_common.c to slub.c
Message-ID: <202311132045.D84400ED@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-37-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-37-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:56PM +0100, Vlastimil Babka wrote:
> This should result in better code. Currently kfree() makes a function
> call between compilation units to __kmem_cache_free() which does its own
> virt_to_slab(), throwing away the struct slab pointer we already had in
> kfree(). Now it can be reused. Additionally kfree() can now inline the
> whole SLUB freeing fastpath.
> 
> Also move over free_large_kmalloc() as the only callsites are now in
> slub.c, and make it static.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

