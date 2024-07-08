Return-Path: <cgroups+bounces-3569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3492A908
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC366B2114E
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B714A4D4;
	Mon,  8 Jul 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8nrr1F2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD671D69E;
	Mon,  8 Jul 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463916; cv=none; b=ZLXUZDiFsfFEaRJeHx/6nnkyyH95btKOTZru+O6FSrL+hQf8u01RMeww8OtKqcIes9CvsRqWLHcLvQfLDA/SYg/KUEXriLlDa4BTt+nRHtpc5ihNjGqDE/dJtDQCZu2XGf4V6dfqNRH5LE/Actl3ER7wUoklAK0vUd/fqwUyH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463916; c=relaxed/simple;
	bh=pkX0/nI1fg0fh+6Ha8Wykvn0qjOrlWee6u+Lh9994/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvMIUVAMWYX0DsdhQ9Vh1SErfgkOkSauf8u911ztZCAbRDEab6S0XhdXII7FGVb/k17UIps9T2xz9wz7jGwnM1KwL3zstgia46vbR8BcXLtx1pgp6M8eOUpgMo0enhH3ZrwL28VMKKu31izCaIpgtJndu9T/MYF0perhFzt2xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8nrr1F2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so2235615a12.2;
        Mon, 08 Jul 2024 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720463915; x=1721068715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psUpNhRVjdyIoYDPztgxUJ9J3hUT46XKpou5MnOXBQg=;
        b=F8nrr1F23efczWGP7eo3Jja/Zy+nRaEWdo1dTOkPDGaVhqgdciqqI4YSXuFmW+fzYV
         0WJEr7vwPxBbpMaie/QSWu9OsT9LScGVrYitqIwKxxkFc9JAcchzSAuCFgHnyjHZnYV6
         uyvncWL+NVlVLRXfAQSiwo9zGzjA19i4fpgZfp7g+KX/iRtaQYG56fP0azyhWHq8QU3M
         nkM2u4xR1wBlD55bSJghZ1Gu3Vb34oiNGQ8JLmFLHwJsznYnaIAYSsBPFiGxNWMFySg9
         ZpjLrl+cL7BzUpT4PfeXLDccE/5hw23z5eiUG4A3PJVOY4s+U9zgvqyzLu3e28aUKWf3
         HpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463915; x=1721068715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psUpNhRVjdyIoYDPztgxUJ9J3hUT46XKpou5MnOXBQg=;
        b=VD2+NpgsAQ96Vk62JJuuslrLhzd2xqTE2nztDAu6mzWcak661u2Ob9XfA3CyEOLwV7
         Nt0cfaQG1Erpn8MY68Nip7o3jG8DjI9+zTWVTyox3y9msGzbgWDrE1lyEhzPUMphJVSu
         lW+a/lmFfBPTfEzczqrR9P43pyg+7RPIkCM183cL/nC16E1kv3JUaL+5M5Cso1n4/QG0
         9xJx01BBYuW7Vq5Cpjfn9J+TYvgJ6yI11r8fzHV+ZpRBx/xq+4CSPP+b4sUr79tUOwqy
         uN+dI9ao33LsFEA8iqZ3bZDFU5c4o8ZNHwss8Guqw/K6h+Pl0hikcThNEOedWe/cyKN5
         UnHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdI6LOQvyEWgkn3G+uSVKwKyxekcr8NmIH3P0ClsjiF4YP/FeaP9ZQcKRAbFE70Pyu8iMQ3EtspVrAsM70yfdyKWeCI9NNdpbcKTTErWwOjhXjsUXSxTorTS4ojZULw5yusyNyLw==
X-Gm-Message-State: AOJu0Ywcmt1Z9bppsR7ab7MPjiwa8S8P7ZZZACEtzE+mC3+7rI5O0OL8
	VGKA1jfvwOoU4frBC3TvPDQBlQpMDSilGu7TPa7g0tfpdxsFg8RR
X-Google-Smtp-Source: AGHT+IF3hZJ6D9RWJMeV8ebRPqPEehxo6K61EQh20aL0o4ImD1NGkMYuZd30tdX983aaweYmHIHV3w==
X-Received: by 2002:a05:6a21:6da6:b0:1bd:2214:e92f with SMTP id adf61e73a8af0-1c29821ffbdmr275870637.14.1720463914647;
        Mon, 08 Jul 2024 11:38:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43969c86sm187838b3a.128.2024.07.08.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:38:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:38:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Xavier <xavier_qy@163.com>, mkoutny@suse.com, akpm@linux-foundation.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v11 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <ZowyKf3RlMI0q1P-@slm.duckdns.org>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
 <e20fe0dc-a3ef-4f55-a991-6efe1a9ddecd@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20fe0dc-a3ef-4f55-a991-6efe1a9ddecd@redhat.com>

On Sun, Jul 07, 2024 at 09:59:55PM -0400, Waiman Long wrote:
> The patch series looks good to me. However, it is a still major change in
> the domain generation algorithm and it is too late for v6.11. I would also
> like it to spend more time in linux-next as I don't have a good set of
> cgroup v1 test. I will support merging this for v6.12.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Xavier, as we're pretty close to the merge window, I think it'd be best to
do this in the next merge window as Waiman said. Can you please ping me once
v6.11-rc1 is cut? I'll apply the two patches on cgroup/for-6.12.

Thanks.

-- 
tejun

