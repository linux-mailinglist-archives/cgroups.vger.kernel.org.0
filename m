Return-Path: <cgroups+bounces-6205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B405AA14220
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D2F3A2595
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4C236A81;
	Thu, 16 Jan 2025 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsoU8HYL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E6230D07
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054909; cv=none; b=cSjQSXfkQ/RXK77+IfHd/knRbE+YLgZ0XySrRhiHZa/av6UQECMiui7ITG4LPVWFxHV+Xu2a4W6R8o/PCUyHiL+UjgYaZX0dKLoRHDxA3qYl9p1wL12Rc49uUxDPmDNoRAjuHknduQjLTcu27NBCGQsIU4/t/rCmgGXljB8MLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054909; c=relaxed/simple;
	bh=+sEVtUCOEnvpxNGKeO34yA6I94hgCr0WaHKfF6gOIFk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LwPkUIu5s3SP82gQGErqpZ8qSCD4AITWNs1xEKbzcIryVVIuDu0aMqHo14lBFkMwnxuOOG6K3QBzHpOm6pmmbWJDLaCUSqtHGdqMzoB79CKdEt8A5+1a42rfBJG0L2UcCnPF+0V8pP1KnORjSfIwnO42r9hHKbeoNM4ltsh7b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsoU8HYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737054905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wFn+zra1tRQHFTOaGuF8DRo9/yvU7g+Hng9H6HWePg=;
	b=gsoU8HYLVEVl12wx8W+ftr8QXIBSKniSh1dNPJdiw1i61sBWWTxU1gLG3dAArV+ydpjzg0
	IOBRXpHrOQZUh8EN4tzDieNE7y2LQKEG17YTF2DQulNGfC2nUs9DI/agH4kfEdp+0ujdxh
	d3jIiAWpYUdMTAwWawCifcs5XsNcll4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-NpFfi6X9M5WY95ibEJHTkQ-1; Thu, 16 Jan 2025 14:15:04 -0500
X-MC-Unique: NpFfi6X9M5WY95ibEJHTkQ-1
X-Mimecast-MFC-AGG-ID: NpFfi6X9M5WY95ibEJHTkQ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166e907b5eso24863135ad.3
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 11:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737054903; x=1737659703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wFn+zra1tRQHFTOaGuF8DRo9/yvU7g+Hng9H6HWePg=;
        b=tw8no30/uiRCKZnkI5r4Gy0LlWDW3b3cMxwjF+KpO+E/Tl2tvKkYlBK5e/Xl8xZBo3
         smip9qM5LaW203GjMPMVI7r4Q2cKdbPgtZrXc7lqx9gbMlnZ/Tnkg5JyZeX+kWyNzhwC
         6bwWu5MSegccBU23akAh+T2gARtk+0GUIlkgHoB7o1cSsRRwj5QicpJSEGwhr9MpWF4I
         3e7PXvg8xSb7/za4szRoW3/d/zmXq76G9Bn8lgMsWptn5YvYH4DHVWby72milZEqyqQx
         108Y8fkXXPDvWftRAMuM7xXzasqn5lXpNZNiVpt1EkPRis8svJe2gaRbVWWYODP8faV8
         nVTw==
X-Forwarded-Encrypted: i=1; AJvYcCX0rOXisRIiBadyGEu8GBspGDtnyfha8W+vCqnMD1OsIUcSKul4GLZMxvqkeGb9SsvdMQqabuDv@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvnKbWQJHXB7O0mKl7GHd9xJEpG9nsMlU1PMeNCMO0iz+8QwL
	5hPeWrqKvelh7sgLFcozNlz3BAkzAeTsMoqjD4/SmhQAkVwkw2lKaxDIHmFRYL7W1tyHxA7uBCy
	dpOR8MfGNTauc4w74haup5KG+LYqeaLT8lqWMVLfMj+8tngZAKe/GiZo=
X-Gm-Gg: ASbGncvSHOCiSw/Hsl8qZp0aChICTI7qw3XK5uAl7knH53phNnR9Ad4CVWZNZ0lP5Ao
	I8KJIxShlNJy5fxmXhRztPAa1HhGb9kYRwf97oi5n9r7WyPoSGh4NTPtJo8c90nbnmSa3wtN+TK
	ttODwiUITk6zrjMNKlL4/E0mgyY/tZtHA9fG3QMWGpzhyVBrbBJAzP/cqEV6GvIe3vMvUu6+WPZ
	SOQzoYQwrKqwwxt2/wq7lxMXVowfrszjuvyj6u/AVGOHKz3whtm/vBqnvfsD+3tlsvW1aaeNT69
	g733SeJjzDSAscXtskOPs+Cijj8=
X-Received: by 2002:a17:902:cecd:b0:215:a2e2:53fe with SMTP id d9443c01a7336-21a83fde4e7mr603562185ad.40.1737054903074;
        Thu, 16 Jan 2025 11:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuuJ4XE4YBqRpZVxDmAlIxqD3WtoUv4F8kqPqHW0nAAwQNqzy72sftRNmbnl4oMvOj2Y4Tug==
X-Received: by 2002:a17:902:cecd:b0:215:a2e2:53fe with SMTP id d9443c01a7336-21a83fde4e7mr603561705ad.40.1737054902641;
        Thu, 16 Jan 2025 11:15:02 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbadb4sm3597405ad.102.2025.01.16.11.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:15:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>
Date: Thu, 16 Jan 2025 14:15:00 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
 <Z4lA702nBSWNFQYm@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z4lA702nBSWNFQYm@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/16/25 12:25 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jan 16, 2025 at 03:05:32PM +0100, Michal Koutný wrote:
>> On Thu, Jan 16, 2025 at 08:40:56AM -0500, Waiman Long <llong@redhat.com> wrote:
>>> I do have some reservation in taking out /proc/<pid>/cpuset by default as
>>> CPUSETS_V1 is off by default. This may break some existing user scripts.
>> Cannot be /proc/$pid/cpuset declared a v1 feature?
>> Similar to cpuset fs (that is under CPUSETS_V1). If there's a breakage,
>> the user is not non-v1 ready and CPUSETS_V1 must be enabled.
> I think we can try given that the config is providing an exit path. After
> all, users who were depending on cpusets on v1 are in the same boat.
I am not totally against this, but I think we need to make the 
relationship between the CPUSETS_V1 config and /proc/<pid>/cpuset file 
more visible if we want to go this route. We should update the help text 
of CPUSETS_V1 config entry to emphasize this.

Cheers,
Longman



