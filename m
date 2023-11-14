Return-Path: <cgroups+bounces-381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726647EA96B
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96596281059
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6AB64F;
	Tue, 14 Nov 2023 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUsWneXI"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B58AD43
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:15:03 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC52D48
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:15:01 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc330e8f58so37670825ad.3
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935300; x=1700540100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUC30dXlQK5fmzms4eR9YZ2PZDBao2AfV4/azmUSi6E=;
        b=CUsWneXIcMotUZhN15TwQakUl4TojQ16Fly7Zo0z1Bnk+y+4D6683M6XAF+U1rpWUj
         H8CSlLmqqegdrg3tety2aNkL8gTPnz+vXFiMoLXMIrrYXyN2XRlE002mM4Szg4B50wRV
         xkLqYuwqrTkBRf5gJPbaODkPbGmU4P53hZx3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935300; x=1700540100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUC30dXlQK5fmzms4eR9YZ2PZDBao2AfV4/azmUSi6E=;
        b=c2gvbuX902imlyJNrSd41tLtg7jp6zLvReCHUUdaHmdIiEx9fZxmOQJ8VdEzTlvZ7V
         W5rIEl5dbzbyVM/jW6QdkQDPV8VrP0SqgH+ndGNiDyKyWg04+9j9T5dDpiFcP7ivSAqX
         HDa2ScfCy4GuKkbw9w6cv1L03f0aAOwKS3kgik9b9yPtrQ8m0n6PTAVtMqRfjySyrRGM
         xeDUmwpYrT05JVdTCTIONGXngnaOSX74JMhNKS2lbs0Ai+v48vQ62TCgFVjG0IruogBT
         x/pozn7dUhPmxWiFvNtZApOIAuWfXyue8UZRglWzZksHEttH3gA5T/6f4Aqj//eQJ3fF
         xcIQ==
X-Gm-Message-State: AOJu0YypNd2rO9r4I07AdYYAnUiQzo3dpoUXjbpeWeOFpc9XsaKiT40H
	TUGMYKjR7bHFVKfAMFgQeL1+Jw==
X-Google-Smtp-Source: AGHT+IEmPIYVtjWrKxgWx/6E037p3LrYP3ZvBjQTSGRoCVVM2HVRsHTaY6qgDIjr5rZO1Nl3XZts5A==
X-Received: by 2002:a17:902:7d8e:b0:1c5:d063:b70e with SMTP id a14-20020a1709027d8e00b001c5d063b70emr1114726plm.53.1699935300585;
        Mon, 13 Nov 2023 20:15:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001c9cc44eb60sm4799660plb.201.2023.11.13.20.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:15:00 -0800 (PST)
Date: Mon, 13 Nov 2023 20:14:59 -0800
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
Subject: Re: [PATCH 04/20] mm/memcontrol: remove CONFIG_SLAB #ifdef guards
Message-ID: <202311132014.F03494F@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-26-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-26-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:45PM +0100, Vlastimil Babka wrote:
> With SLAB removed, these are never true anymore so we can clean up.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

