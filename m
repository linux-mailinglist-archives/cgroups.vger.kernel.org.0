Return-Path: <cgroups+bounces-465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C07EF76F
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827632811B2
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953D30CE1;
	Fri, 17 Nov 2023 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSGMeBnt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD2B8
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 10:22:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5aecf6e30e9so32762607b3.1
        for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700245340; x=1700850140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67j9+17m/+Ov80pCnuJ4gd7d1de7FvoHgKDEaTGjv7Q=;
        b=kSGMeBntGpRqx80iSRFYbnKN4Yh1JeZxEE7yL38pqfk01AD503Hb6O7BpTj9k8DMOV
         xfq1mCWTdmypM1YKKWbyjHMoh1/XC87Uv6jdTNoBhzZD8b/tMShAveQMa1BMBQ+FgdbE
         RA0kxyNj3wg2Vmk0pfJhUcsrVYQpQ/W3SBV/h/oTwDENqGpBxWmi6v9jlgkSTlhxBDux
         QNXVgMkVjgW/EBLMhO206Z/50cedCfohosK0DHX12DAF9gajVAngkjkm8D/gjkOD/77B
         WPbPH+fh5ElwfXRBZ1/OHy4iAZ3JgUk9DLrezQWxzqgLLlMds0/x3dABznvLzBsMXewn
         VaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700245340; x=1700850140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67j9+17m/+Ov80pCnuJ4gd7d1de7FvoHgKDEaTGjv7Q=;
        b=mLUmJtxqgZMME1X09a/zUxS3LBYcqgMhoMGB5qjftJ+10D3x19VyO8vzd6OdMlMKrJ
         RuM28OcSIGp+VSh4mkF5QFi8gfsV3GirRYetfmGG9NLTyDBrjxNrd5Qnf8yMeITGzMXy
         h8W829/vBg3QWcS6Ka5ondoDCngGD30LNTrXeKl8nGy8jXsc3kx7ibnAzTIjxHk3HqlJ
         5ltFNCi2r2qsHgbrKod4lhIm3xjjpfpWhQy77pinzeKIz5iych464+iNwn5qqI6xHJlU
         FZfMqs8929g4WIRhedurpFS775rSxw5v26PhGlu3YazsXzl6IN97RLV9TL3b927QAh4l
         s0nA==
X-Gm-Message-State: AOJu0YzVn+wMFT2TGDYgbDqkoUs8k2ZY2tIZNUhSFupbbQmeewLDeRWv
	3PdZr4NIw2wcbyOMWMyCsIpwu+DYmqwtyw==
X-Google-Smtp-Source: AGHT+IH7L/taQjdqofqQV9IwVstSBvW9UJq8dFBgbmoT3PvQXn1ozGa9Qj0rost66bwraph/3YhtM1xyxg+Ykw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:abe3:0:b0:d9c:c9a8:8c27 with SMTP id
 v90-20020a25abe3000000b00d9cc9a88c27mr2829ybi.13.1700245339605; Fri, 17 Nov
 2023 10:22:19 -0800 (PST)
Date: Fri, 17 Nov 2023 18:22:17 +0000
In-Reply-To: <20231116022411.2250072-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com> <20231116022411.2250072-2-yosryahmed@google.com>
Message-ID: <20231117182217.q6nkynbh24wyti33@google.com>
Subject: Re: [PATCH v3 1/5] mm: memcg: change flush_next_time to flush_last_time
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 16, 2023 at 02:24:06AM +0000, Yosry Ahmed wrote:
> flush_next_time is an inaccurate name. It's not the next time that
> periodic flushing will happen, it's rather the next time that
> ratelimited flushing can happen if the periodic flusher is late.
> 
> Simplify its semantics by just storing the timestamp of the last flush
> instead, flush_last_time. Move the 2*FLUSH_TIME addition to
> mem_cgroup_flush_stats_ratelimited(), and add a comment explaining it.
> This way, all the ratelimiting semantics live in one place.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

