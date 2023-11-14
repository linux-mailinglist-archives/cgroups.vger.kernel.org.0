Return-Path: <cgroups+bounces-391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5697EA9BE
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136681C20921
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC698BE3;
	Tue, 14 Nov 2023 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NyU7RZ+O"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE539453
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:44:48 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA64123
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:44:47 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5872b8323faso2984493eaf.1
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937086; x=1700541886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTW82VIg1zc6gWMgLEgKtR0yngdsI70qEuPsuyspTwo=;
        b=NyU7RZ+ObqZ3uQJelOG3FXRelZUwirl4yNnoKxS4uJcr/Nv+yeP3kSkVKbOntiW9kI
         GOGnPH61PvKnF9q2fNzbMiOPa8PenGcx6QY6yaLmSZpIFeAmRpFXyWTHgIBWHJxttofQ
         0C0lU/YjG1cXGoKO7QadaPHxuKWKGtcBLddF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937086; x=1700541886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTW82VIg1zc6gWMgLEgKtR0yngdsI70qEuPsuyspTwo=;
        b=etl/A8GXjLB4OuYLqkt1QlAsgPyh44eKG8V0iE6u8JGmYfIOszVd/ZmuvEopwZF6qt
         GZEqRfTd9mU3kLzxghI0NguDwq0F/lTjK09FqNjjWTgBaPC4J+GpiwCyrO0fv3K+s/vr
         HN+CXV1Z6oV2kz3XByryfNQyrDqPDMtzMFzmt+a+bugUf8YLsdyzT/yRBpSMu7HO6bpp
         yNogd9U9K9TQLqI2QKZAi3q8SIsZhNLM7PB1qguhJeB7mgg5V+6lgIAdmzGy24Sf0iip
         uNFpkOPb9xydssCt9QgsGNtOLuPu96zWqtysq9sh5OT7Jo3THGynUKf9L3cLc7t+GP0g
         vLbw==
X-Gm-Message-State: AOJu0YxlocVLPJ4pqoFZD9cXrbMFiuNtxD1pq57UyJQ1HHUFBojohLAp
	ibD5CP4+7zOGVA3g4UUFoIf6ug==
X-Google-Smtp-Source: AGHT+IEHSCi3qmm+CEYh5S+KHw/ma3E20e49n+ffxfRFPgJdN9lczSQRNAtSX+4ACW6uKlNfJe1Emg==
X-Received: by 2002:a05:6358:3411:b0:168:e614:ace9 with SMTP id h17-20020a056358341100b00168e614ace9mr1513512rwd.11.1699937086576;
        Mon, 13 Nov 2023 20:44:46 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a656910000000b005bd3d6e270dsm4044377pgq.68.2023.11.13.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:44:46 -0800 (PST)
Date: Mon, 13 Nov 2023 20:44:45 -0800
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
Subject: Re: [PATCH 14/20] mm/slab: move struct kmem_cache_node from slab.h
 to slub.c
Message-ID: <202311132044.6DE1B717@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-36-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-36-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:55PM +0100, Vlastimil Babka wrote:
> The declaration and associated helpers are not used anywhere else
> anymore.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

