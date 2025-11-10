Return-Path: <cgroups+bounces-11720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97979C45B89
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4303D34706A
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3354301477;
	Mon, 10 Nov 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V81ddc2q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB2222562
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768134; cv=none; b=DwvEo3DPXKXFc/SHKiGX/mBCC1JlWU1ilWeO/r5aWHJSojfobrJAVriQC8Oy3yX6Tb250fxcCLNPQbyuu9pP2lRYH5ork00fHKUzZMdPGeeNAEq+RNiu+1gpSnqB2v7pqxQIqWaHOO6fdHBZj02rhdz4aHGjMQjmnacs97M3WvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768134; c=relaxed/simple;
	bh=bw6QasuA8KeZgfQP2n/F9NjjLOI9T9u407i64LyA4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xigh1dAdDdWj8s5fM7ykUATd7hbiVEvclUXU7IBTqZVFP5daJqTknOWmDPWblMHNd9gpD8KbWjrOBChL1/HsIK3YJ84h9/28RQ+eVrM6EQs/iO0sVANqgCFS+HWSvJ1LSrDTTIwOblQfGYjMToEoObs/Ynl3ci4KsZlkOSPpOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V81ddc2q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso4756776a12.3
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762768131; x=1763372931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=V81ddc2qxiRyTqCzgFZIZ8VateSKEepBtEeHhkhJRYWMIbeNYZtFKGbBfmQ+kNJ0pI
         vfNoGO48VVKoZ5p+wto6BQkLMwI2mTUSN8T7kxqunTPoqV/HC0Hx++AKHY0IH8ZVfl4F
         3awoP5efGFN3YTdaHQqNUWIOJmOWKOSzxOxdc8RTRLl1/77eBYm6ABRef9wt5wLEAsYw
         jjV1sGafv1NRMsjYslQd7nNppLaKavP+rmQuOzOLXsLkh3kVhWVB+xV1HUEi5DEcqg3O
         EJ9I1bsTi3H7OXjiVoB/7rEdyRqdI8zCFB3DIuwY18qR4tGbNPvNeaCxxg9he4UZFy56
         Enfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768131; x=1763372931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=ecq6iOHuzBAeWmjV0PjoEQW36b5FJiiTwwP3jhM3+TnHlmKpHYOLRYmygtMfN4pBdj
         0nN/SBZj1EMtNqR6lL9Ie9xfrUaXQnoaImh42d4OQC1FXJbBxg8vxvyqlNFJ3RSAh6Zs
         J4urbqdK4Bfc76ys8OY+5EnQF56HNRPOsrGgdqn/NfMeuFF6nPKWHdqm6qoUGOGss4Mq
         CSchT8OGin82N1sijAz6jcGC7Jr+OP2t7bzhJQJEMxAcM/10ZtGJeagTV6MqpejxIo+R
         F52vak5riLS/txWMUfp0ceCUV+rVKoxWcHSjyx7FfULgvTViL3Epz9tEV74wPMAALW4t
         uFbg==
X-Forwarded-Encrypted: i=1; AJvYcCW0wCH3SM9aOFRoSM+Ysy46HRO8BDjfS5bws+dGcb5byxxRdITHLGoRCFqaa1Tt0slEScNcCiA4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zTCkQZ9oXCfqvlhqn+qYrIeP4jBQZ8JwL+gzroT1xPJajqWv
	dUg38gKpEIiKyztgGC4Pk7agw7092G79A3tR0AO2kxc5r1F5dbVpJVr50DWlrFw/OIk=
X-Gm-Gg: ASbGnctefvpaGxkudc4rjac1oNoAR1EcukkdsxiD0WiCHQ1aRZ4uW17Fbq/LiXxpMOC
	kYOv4mkWHuUYfYGhDVG7+iFnJJO2ODn2pTZFopoVLPzOVIdLY7JbWRe3Auk7Pfd3evBkNzr7l8A
	IhTjJhwD2h2ILwCBxhh3aIvQiatSJxcDx1vk9btyrBivV7+cu6A1YXjAVzBdjFg4d7TY4yWt/kA
	3wrK8IiP53JRhuAqQK3OMhDKZ6cTAppYBGSMZg81N4Ax+QB3YhYngwSzkuUd0qyRsaiH3vKNPZZ
	Fw1QwM/OLdNIcPS7hrNPouSvC6f/vaeomZgan/vU1NyMffghusLLjqJzpxgh77EVGaIfo3yfJxm
	7896ItxZtx8Y3PDMTsoxtsNVvMQoDI2zvs5/8wNq1M23a5DZJJvIHJRrMg+0K6iL9NJByUTv76y
	+Uj6IybjOPHov45gkLbp4NT6AA
X-Google-Smtp-Source: AGHT+IFxQkylFq2Crr8V5DsL5/o3I3bsVnjZJeM/h5I99Cls23cajzpMg5CawHlhDUEoe8P5BasDOg==
X-Received: by 2002:a05:6402:50cf:b0:640:da69:334c with SMTP id 4fb4d7f45d1cf-6415e80fc71mr5848770a12.35.1762768130923;
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm10864916a12.14.2025.11.10.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Date: Mon, 10 Nov 2025 10:48:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
Message-ID: <aRG1AX0tQjAJU6lT@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-13-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-13-roman.gushchin@linux.dev>

On Mon 27-10-25 16:22:06, Roman Gushchin wrote:
> Add a PSI struct ops test.
> 
> The test creates a cgroup with two child sub-cgroups, sets up
> memory.high for one of those and puts there a memory hungry
> process (initially frozen).
> 
> Then it creates 2 PSI triggers from within a init() BPF callback and
> attaches them to these cgroups.  Then it deletes the first cgroup,
> creates another one and runs the memory hungry task. From the cgroup
> creation callback the test is creating another trigger.
> 
> The memory hungry task is creating a high memory pressure in one
> memory cgroup, which triggers a PSI event. The PSI BPF handler
> declares a memcg oom in the corresponding cgroup. Finally the checks
> that both handle_cgroup_free() and handle_psi_event() handlers were
> executed, the correct process was killed and oom counters were
> updated.

I might be just dense but what is behind that deleted cgroup
(deleted_cgroup_id etc) dance?

-- 
Michal Hocko
SUSE Labs

