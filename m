Return-Path: <cgroups+bounces-11817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D6DC4EC1C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C10188E759
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C98357718;
	Tue, 11 Nov 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTE2bqLE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oBhy4I44"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94846314A85
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874201; cv=none; b=BPq4V56WXon49u/KeNhMfwW2XBisEmZVjmumg62AwL8pUCQ9eaXCBhV1xgynP2R2ZDYoDS5skKSeKMt1fX+4M+Q/B22Iy+kn7BoSCwQNdlVcGdT3keq1ng46cDE0HyUWz0N3z499bsqwHx9X6RrCVVlD290hoh2N9NSS0jefqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874201; c=relaxed/simple;
	bh=4W0pTQfMu9etHjodXoCYPTbDHsUcSu0s/ucskpokDRo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hvBmxO/nyazgDlgwUHTiLfbZoKJXWp4iyGO56LqJ6oL/CWJriwApppTVMz+1ERYf7Ub+6CfE4JHNhdRqCVFCtThIod+q/Kv0dKZZ4jjnOeatdbHyAauEKZOyMb08jfeenZFVFDIAVIl+nbdepHCgGfnNM6MTmkdrdSxZpSibr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTE2bqLE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oBhy4I44; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762874198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
	b=YTE2bqLExx+eA4/bjuV4uqB8SlhsEsD9oTMjrQ9+5XeYZfKi/sI9F6Kz/d9PrF2vXlkO8z
	xpg31NNQHyu/G4opy0wHZWRT+aM81T5GnWvzBkACoN8xuSbZe10su7xOn8p9UEda67gAoa
	jAwoqXrvhnzJGDhOPeY0pGufWmZo+AQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-EMXUomjiNJqThqex0UClig-1; Tue, 11 Nov 2025 10:16:37 -0500
X-MC-Unique: EMXUomjiNJqThqex0UClig-1
X-Mimecast-MFC-AGG-ID: EMXUomjiNJqThqex0UClig_1762874197
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88044215975so150460186d6.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 07:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762874196; x=1763478996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
        b=oBhy4I44+BEFsNbrk0LOs5e1i+FX04N1hI/FeKbcO+qSgUMQdsTHTUZETs8kH0q044
         8uRfehvVotH0p3njLffUU3Vz/GkNgBAth36bRbVa9PXf8GONBntHZkNdQRP+iZDyoJbS
         4gRGiP5rAozZZlH0RYdORC+Lp7GFclvzaZkMOtuOvxvBU1J3dgESFhjgkCPdfgC+krp9
         LBh7NEDoFI3VtUBMmiCILfUxywpfnccDdamiovi3FhIOXtmZblLD4rbTCsLTlQD5yizT
         8z2olZMNUkkMWMNyd5d4PJAccJTTQycDi5iNmbnd/9IneQLWsDG1jY4YyO8yBRutHsTZ
         xjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874196; x=1763478996;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZo1AQWSnfv43DTha1xkrKb3ht+B4Kvjw3ow7j9JdtM=;
        b=YxE2L2vDdFJ1JZ/SSlGMIOuj8vp9tHz8bFa2VD9VgBN0MOUpdL9hgXO9eAtmB8gMou
         XtMe4f505qOO0aCtj9NjylW+MVH63wSs3NowhU8C9qjBeZEJACKHyS4Ns5XgGai8z0xs
         eQaBpjVrlxuXYg+4U4h9fyqijGDj39SaA6cOd//+eg+3kMGK8JSRCYSDsSm59iDpLctO
         WZHTE6bf8Scul9FuJJnkHIkUcdbYCNDwlV5hHyox71z9CKlnqrUPUjQWZ56q6ExyCX3a
         pVSlsJOyIAuqihWZcYSONTRLXagwUlhHtv4mAtV3W6fRTs4qOL3cteFLOf4pAIZ9CQsQ
         NQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUf3cG+oW1ydhGNzK9KuBly+WpEJm1GKRAjaIodKV9qok3c21yQjzS4yGSk/kJ6EAA2hNDXwD+V@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZda1VsvqsTI4rswZt+UpxNR4lABPj6fr6A7qr19Fw/hCuxTk
	QLVM0ngmmm7dSwmsnOXblXJauEEiSFKzOgndQU9pLRur5rUz4fbRL4+GELyZr/3x8Buj5Eb4t9l
	60V3ch8HGtJANuw67GT03BUnDHydGqoaR2Ef92ZcUWfimCImLzyVEKzDeUjYwSeKv4C8=
X-Gm-Gg: ASbGncugB9dNEympBCe7DCXD/XX60VCK8ZO8a6eZW8D6aCqVpyesaQZCt7NC7zZ5LZR
	yzxlz6eYHIRbAqZAJErxmH0kv81ACtmKrv8geFw+e+iVyLWYsyXjU092ox7zAytV7LsciwAVykR
	VJ9sNglGKdply3VC+RLTBNgV4QwWkoRhV9mM35Y/ZXq/0DUo88/ZeQwlXIzFi/TiJ+0lbDCInuZ
	CseUBDn15qGjJSxk2v4S5wmxgb8GDOeXPT0GCzVKqModWHnphy7x9FPvqBP+s0Qzj7H1MGi7bel
	yOLGhUn8gceqP3n8vHdGS3TjamwphMsAcpd4VOLAXSyyrFYVroCC3WXXfM+ybidg7wngep/WSIQ
	10i8KplYqUb1XeG7a45VscG81BAku4l8p2xds1bdGA6ChjA==
X-Received: by 2002:a05:6214:1c0a:b0:87f:fea5:876e with SMTP id 6a1803df08f44-882385b834dmr149269576d6.10.1762874195789;
        Tue, 11 Nov 2025 07:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3NeH7/OIy+qUuqaSbJt2jgTZ6sJYqaG6aRRBJNwlPaRrbHA+xi9PkUix176w8VXhHJRIKlQ==
X-Received: by 2002:a05:6214:1c0a:b0:87f:fea5:876e with SMTP id 6a1803df08f44-882385b834dmr149269136d6.10.1762874195393;
        Tue, 11 Nov 2025 07:16:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b75896sm73149916d6.49.2025.11.11.07.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:16:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Date: Tue, 11 Nov 2025 10:16:33 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
Content-Language: en-US
In-Reply-To: <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 9:01 AM, Michal Koutný wrote:
> Hi Ridong.
>
> On Tue, Nov 11, 2025 at 01:26:32PM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
> ...
>> +static inline bool cs_is_populated(struct cpuset *cs)
>> +{
>> +	/* Tasks in the process of attaching should be considered as populated */
>> +	return cgroup_is_populated(cs->css.cgroup) ||
>> +		cs->attach_in_progress;
>> +}
> s/process/cpuset/ in the subject
> and
> s/Tasks/Cpusets/ in the comment above
Agreed.
> Also, should there be some lockdep_assert_held() in this helper (for
> documentation purposes but also for correctly synchronized validity of
> the returned value.)

A lockdep_assert_held() is certainly needed if it is an externally 
visible helper that can be called outside cpuset. For internal helper 
like this one, we may not really need that as almost all the code in 
cpuset.c are within either a cpuset_mutex or callback_lock critical 
sections. So I am fine with or without it.

Cheers,
Longman


