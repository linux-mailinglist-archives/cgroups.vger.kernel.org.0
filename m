Return-Path: <cgroups+bounces-7481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBEA867F7
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3A3BF175
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B62980AE;
	Fri, 11 Apr 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyYEmkt+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563328CF6D
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405962; cv=none; b=fdVkO+GkHLqX6o/yV20zjS3ajG6ASeKOm/sM3l6gDU5GKsnITnQvtR9Crt5dSB2ev+6HG6VzcO6PwF4ZvxGS9VGLrCAT+SvNHqvZ5u/jOgMSFtzSo1GKQe+IMScfRYIVUBq9chMODaQ7w41OITdNf6KARaMH03w3Nt+pqiDT29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405962; c=relaxed/simple;
	bh=HIoeRzZ4XL/sqMS6l6dsp3lLVoJy7wnMtD2NyOs3WuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXyUO6gkkmJjxH+1Bg6JZ6ZHk1mzuXNmCfDrV62fU1UsKfXSymErWFXiA1i9sIpx0Nz2FNCee2Qeye2jXc9+pZ0HJRiL/P6SISE06Ef3Dg7EM2Eplskx4/hXSpX0vzXC+3YB6ZUJU6wFvcKVkwjqphCpqal7ygqHfIzbTKJT4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyYEmkt+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso2051289a91.0
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744405959; x=1745010759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTerkmabK1RPmin6YSGz3yw/UPXy21WADjby6VaDxu0=;
        b=lyYEmkt+4W/qmYTbqLfgcKWygcpTCT+AcNxQPJV4qwTs3wfz/+CvHP/PqFpPfgL09i
         rcopAT+whi4UWNcTSg/HVJeSGrj0CA7gBa5NcQ6FyN8uBirYoUYvwN6XuxZUeCPIFFrN
         lGdqvfm+/X9XO2lbFwqd8SlNNNyaukBAURqDTv3xyPDYmqcWdAKAbyu2aou2gZRCpscc
         hRPihAiiaeGODqPuibtDr2NjQsJwvkyJdrduBduRFKMZERwp4Kpp0ouTEVYMS0XpY7Du
         SWLjrZkqUJoQMBIDI45oqQJADgO9Q4T/feG3mimLQsZrBdkgn3b+SfKOzMG6xROfsmGp
         tx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405959; x=1745010759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTerkmabK1RPmin6YSGz3yw/UPXy21WADjby6VaDxu0=;
        b=D+dObwdgJOA5G+SWGmiH5IrgfnR3V2Fnil+W/gGeeUDQMaWNf/1Enxs/MzBBKoN42b
         e9usdPEKjC+zxQICz1Y82MIzgf9We0692HvXhcxHukqktaXmzi3sa1bsj3LAt08L5G1s
         +CILSxD4A4Eqn7JEaJv4YJKcYMBfM7lnuvRVT93sXCLDmJh6utP60hEXl7618EjkPsq6
         fEU50E7JdPxRfMvzt40FdemuZPPlul+fUA4LFaCFVP2RqLnjjTgg4HcatL8tvq6dmXkH
         j88PjhECo/UvB6Nb8eMyl7ZDaqVU8wJDufEoM4hxob0SDqKDmicQI1U+u2reNf/s/xEE
         zMKg==
X-Forwarded-Encrypted: i=1; AJvYcCXIxkP1p1d5sKyMmW5jsSJrpzX9nOfCCjtapRBYb611QqCW1zBqanZakDbgmDo2fDyW3QTPbZ8U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26yEzPjvFzONDgQMnd5YQub/LrytOS/P/dbwi5r0VjoFfjqsV
	2v15l1BLHOHytPfXXa3tOKhu+PMIhFB0UedEHtP47ie0gTqe1NlDE0K64KCBy4ovLRN/368CeRa
	N8Q==
X-Google-Smtp-Source: AGHT+IHCwmlsejUy/39yMP4wbG3Y4o+uj+/0NvNbE4QYI/YW+78TKNJvJdox+x120ZMs4bTF49FtEDiDTlU=
X-Received: from pjtu11.prod.google.com ([2002:a17:90a:c88b:b0:305:2d2a:dfaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5403:b0:301:9f62:a944
 with SMTP id 98e67ed59e1d1-308237cde17mr7424213a91.33.1744405959367; Fri, 11
 Apr 2025 14:12:39 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:12:38 -0700
In-Reply-To: <20250331213025.3602082-2-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331213025.3602082-1-jthoughton@google.com> <20250331213025.3602082-2-jthoughton@google.com>
Message-ID: <Z_mFxiXcWKcxRo8g@google.com>
Subject: Re: [PATCH v2 1/5] KVM: selftests: Extract guts of THP accessor to
 standalone sysfs helpers
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 31, 2025, James Houghton wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Extract the guts of thp_configured() and get_trans_hugepagesz() to
> standalone helpers so that the core logic can be reused for other sysfs
> files, e.g. to query numa_balancing.
> 
> Opportunistically assert that the initial fscanf() read at least one byte,
> and add a comment explaining the second call to fscanf().
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Needs your SoB.  It's a bit absurd for this particular patch, but please provide
it anyway, if only so that I can get a giggle out of the resulting chain of SoBs :-)

