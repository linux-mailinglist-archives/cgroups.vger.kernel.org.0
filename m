Return-Path: <cgroups+bounces-10604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31DBC5527
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E483AE2F3
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8500287512;
	Wed,  8 Oct 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afZ3B0I8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC3285C83
	for <cgroups@vger.kernel.org>; Wed,  8 Oct 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931663; cv=none; b=UBME7l1lwkeiMozLA6lWGfSgpo31I9e6jbroaYtTkfAZ1fEqP6AuByPCInD0CNmR4edqRhM3fhgv4VYdNfUZth6dXgv7GFvi3joyQarCQsKWFSpPV0mgeam5w2Ge7Lk+Nvo5OQoV2RSNFWjTaEtzuMO6JZqsjtfYQcy7uFwxRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931663; c=relaxed/simple;
	bh=Q2YXGjIR+rL8BrcfhhvKfyIjtqjvZ8rgOU/s92qDdFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJon+WCI9JNrHOhHDwfjbVw7efLmKKTY4bp41bPfV0fZWP9KTBXxuMP09e4ajXA8R3OoMqJ/sN6U8hJ0mfkZv1psiE8IAO4qFu9m7BEacF368t1BwYSpQfD1r9SdVmEDezb0M+YmjLhYH7wsH9qIYqFBWmk7d0zc+3pGcD7orjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afZ3B0I8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759931660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
	b=afZ3B0I8U6Iajx5kruuM6BTlSc5HgoKSF+UjRZF2YyM9KbLRrIam3cY39wQ/vUYZ4YayZ8
	DQDDBcRy74S8VjzOpUUePGa9C3/U+vO6iXLP0l8l1ozyxCYxdMG2FRpVPxfNFgplzgfz7c
	yhyKp9VP83gmVLMShKZIDgiUFmVYeQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-rhx4ivadPcyYi2ywcFJ4pw-1; Wed, 08 Oct 2025 09:54:19 -0400
X-MC-Unique: rhx4ivadPcyYi2ywcFJ4pw-1
X-Mimecast-MFC-AGG-ID: rhx4ivadPcyYi2ywcFJ4pw_1759931658
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so4111740f8f.2
        for <cgroups@vger.kernel.org>; Wed, 08 Oct 2025 06:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931658; x=1760536458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
        b=WtEHosPMRrSKcwdtk+6uB6Uz06jAMZfPYAIRwvPTUbJ80729PMoyZuvw3ysrgve5qb
         n0yZRsQ36PORPkD3L1CY6Q6iM3cJL82qSUXu8l1AO6GzEq2LzNNpPRtrXX5VrmXsd2lu
         7TK5m0Yhc/uetpTdrxZi+VonKAItAgEELEmNiTUpgizEeu0qwKnlaoWxLLZh0B6DU9te
         RF5IDEbNLy1rt/UEHuIpJGbrIhP5pFR56FrN8lezT8YBY64LHIVfQ21zCs6GDXcRQd0Z
         flWL0XC5DnQ/yX0mj4ITEo5EqYeIJmYsqCqJJl5u+yLRpCE92X764zCwe0kZYiA03WCL
         +sFg==
X-Forwarded-Encrypted: i=1; AJvYcCUN/0MN9fXVIySHtoC4I9e74sCTaMuu6YUZhWZ0dziINqnA0JGWdCCBiqessCINVe/IEp/ztQDe@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmlERvnzqHtYqRIel4rV9bqxM0vV9+3m0tr3YQSH6CvlIeRy6
	UiXfnmwDipT7TD3FcrfeIMxC9FSQXZD/nfaC+Ti9/rZkg+u3J3LkefzXbkFvanyTftEYARAZQaM
	RhjwpvaSLWpCzm2/lC9kHpBKJVve2ct+5Z0vU/pD0AebleP85uaAhaZhJHsE=
X-Gm-Gg: ASbGnctgBEJ/ct6o2bQb3nTd9u8j2jPFJStb1y6Y2Ggrq6nBrgyxaMcSS74+L5/zEcS
	KC/QMsgd7eWytla9g4ZWM+QWlmnNUNnvq0qFmRF8AtlztMA/uFwnL1diem+x1+gCWurgfzWBNG2
	HmrHRQse7OcROl9hlnkckf6NA48ybbY9S9HE+4HK9eU9YfsMXlQB8qSN8+eakYnaoFgE7ZW2T48
	/+RxyAAomoAn2tBboOGRrG487SNmPnGdSx7kOuhDtl9zNkA8hMvnza4b4Qdex9sMRbcgmZMYFtI
	L0OLk3/LhrvucQ05jqUORB02bGrxBne9NG2MLRZFguUGscmtJpxUieE4lrMGmLMLjQriLa1np90
	HSmYRxqZgaKqBjQBFUbcAQU9PcH7DPa4=
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172151f8f.37.1759931658000;
        Wed, 08 Oct 2025 06:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6pPCr5ooWIlJwPz5RcCzOYg/HVdYm9VLX5s4KNvCsNHbATSOR8rWb5OHNt2RclD3WmUKfOw==
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172132f8f.37.1759931657552;
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm30003416f8f.18.2025.10.08.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
In-Reply-To: <20251006104402.946760805@infradead.org>
References: <20251006104402.946760805@infradead.org>
Date: Wed, 08 Oct 2025 15:54:16 +0200
Message-ID: <xhsmhbjmhh52v.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.
>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>

Other than what's already been said, that LGTM. It's good to finally have a
canonical change pattern... pattern? :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


