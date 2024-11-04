Return-Path: <cgroups+bounces-5420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4B9BBBE9
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0871C20FAE
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BC1C3034;
	Mon,  4 Nov 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6GA3Vu8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71501CD02
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741441; cv=none; b=TU4JAqiAWKCF0vAd/EiZFK5qZxldlWJlqdwKOjIy+Z/CVtx70osF1LtccMjuxm39JXbjemYNwg8AErwbbB3sX5vZkpRQjNHD/n0eeKHX3vIZRSkcretecfVPmYK1luqb9pW75cJCBPMPQID+uiOgpJKULIHv1HDGyyIv0eZHZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741441; c=relaxed/simple;
	bh=/mFCWCpaBZs2wG9hSEe600YSbGFLNcouMVo90maLyig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b07v2CDTOFrWAO1c8SPRU6Sh03QIR+0stGbTSDag2qYAsRTg0CpAYUHysERE2Z3I67jNx7y4tkqFuBdiDFsH1ckw5xmqS2dTtv6k/h09/u2GSIZDRnUwQT8akLMA3naGKkxHW6lmM4IhObByFk243+jWg2Q5cmW+VBCRf8THSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6GA3Vu8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so3064696a12.3
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730741439; x=1731346239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uko8HRkTeNblmOW9btgKs6zqXzdL6OFUo+xRmjIxbBI=;
        b=k6GA3Vu85WaeOslb6nVAyBImufIgCqBcLDiDVx3RxeW1swYhmwKo7MkOWmVTmpdlai
         ti9JGTZfXBnCDYgDbtss554TY6vHFqKHqwL++A7Qphna6smKcdui72qpHya1h9bHkR04
         +Z1bR1XS1x540Hbt3GywmKEz8r6UaBxAxLK1NL1Ar+Qu/VyI9xmPmIos/tM0+QaXYcB7
         PGBJ9XbYFwT+By47VNtM8P1KilEDMy8O9hbbKq0VznXJCJqdGT7H58i2HMf4VGL4+Qmf
         bcuL+EIesQfuroHh8C743/FQ6IkRHkPxTTXOF4RyZCTZuYlxTSw29cZSdKrLBUgAWOyd
         keTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741439; x=1731346239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uko8HRkTeNblmOW9btgKs6zqXzdL6OFUo+xRmjIxbBI=;
        b=jKt8HI0A9xxpEchEGPCZtYfpY3AI5aZoOfxq/id7Edb3yOlBXyyFCBdop/rcGOzZGM
         mo8gn4Jd/bvPLQTWf6cNCxt/hw4wZ2WlXUl3mhzzZ6+IG6FOF3ba7FXESlu3l+/0u9hi
         9BaAUFOxGVopc02dMyjhAjeYy1X1o01ZIn1V3PQ/F9Suc4Y6EqpwUv7MpDLqa3VvIdgW
         yzMG2cmYPW7guuAl1YI/cCK95oj/Ny/d1PsP3NkOR7fxqD2kILnokSi+eDIvk4RqKMlg
         jqmLXRmMxjICPRTOSOvWAffwOx1lpGmjn0xKtj+SuZ8UwxNPnnc43RJQqJFMooyGA+x3
         66dw==
X-Forwarded-Encrypted: i=1; AJvYcCX9DOvPObMxrKslharmm+REsFTbL11/0DV4q5SrCH0Ctp8RG+jhxfSJQcENwAlMHfZCufyX2P5w@vger.kernel.org
X-Gm-Message-State: AOJu0YxwxBp+EojWWM5aW3MIdkwHfDip1VgtCzNpG2RvQS6PhOPsTTHc
	g2JqXzUSv8wtEgtoDMz03F9nP/i8KelQJbQbWN8+1GY59OzukIaS+r0/cTjNxA==
X-Google-Smtp-Source: AGHT+IEGOOT/8Hf+1rAAAGQHfgG5uBjGTgnPTvESY0/W1ruAvP96UeZmKwzbhDibddrutT5kRXi5Lg==
X-Received: by 2002:a05:6a20:b68a:b0:1d2:e8f6:818 with SMTP id adf61e73a8af0-1d9a83d0a95mr45329316637.17.1730741438695;
        Mon, 04 Nov 2024 09:30:38 -0800 (PST)
Received: from google.com ([2a00:79e0:2e28:6:e673:81cf:d338:f1bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c7ef1sm7698084b3a.103.2024.11.04.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:30:37 -0800 (PST)
Date: Mon, 4 Nov 2024 10:30:29 -0700
From: Yu Zhao <yuzhao@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <ZykEtcHrQRq-KrBC@google.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
 <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>

On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> On Sat, Oct 26, 2024 at 12:34 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > While updating the generation of the folios, MGLRU requires that the
> > > folio's memcg association remains stable. With the charge migration
> > > deprecated, there is no need for MGLRU to acquire locks to keep the
> > > folio and memcg association stable.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > Andrew, can you please apply the following fix to this patch after your
> > unused fixup?
> 
> Thanks!

syzbot caught the following:

  WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
  ...

Andrew, can you please fix this in place? Thank you.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ddaaff67642e..9a610dbff384 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, int gen)
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
 	VM_WARN_ON_ONCE(gen >= MAX_NR_GENS);
-	VM_WARN_ON_ONCE(!rcu_read_lock_held());
 
 	do {
 		/* lru_gen_del_folio() has isolated this page? */

