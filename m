Return-Path: <cgroups+bounces-1314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6509847585
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939781F25D49
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49014A4DB;
	Fri,  2 Feb 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4IxiEFF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593814A4DA;
	Fri,  2 Feb 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893359; cv=none; b=FHlo6s+vCXjHygQC+QiCrvFRfhc7SrOfGVisfc6F/eT4/yy5KWriyZe3CioM903KyukBh5pbBJxjidJAqQqs35UTaemqIh06s7UXbtiY7IK9Ggrn0MiZs08QOTNbZaAytNjsdMfPuY7+hhRaC9b1r9Fco309rNtbuRXHbFK7cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893359; c=relaxed/simple;
	bh=M/XghYiEhB6qJRmpPvGtFZKAQDh38LR4sWRn4tSHzHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/4lzNOUQzAsec8NBj+dbXPr3ILHBInjCYWrBuv1XBsyZtDIaTbCaYGpb9ebfHK/mJJyiyWlVIeCpFGip5eP516oH+Hql6MgTzylRzFunhmgI17dMzfidnvg1qQ7EMSxtXdD4BwgVojGTQL1pPapUpPHrVDFg2UTY/3dshhmmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4IxiEFF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746ce7d13so19157685ad.0;
        Fri, 02 Feb 2024 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893357; x=1707498157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFOmOmNEsa/AsVk/zpgj1QL+CV4itz1nj8ImSJN4DOM=;
        b=l4IxiEFFSUjYJ0YQMyXEosuN4C+vwt6oXzhO1AyXIUdJx70y4GyNqm3VIf/qZqe8eL
         pHFS/V7gI0j63UwhYmxD5VJ4T1S82DNrwPGGx3foFuAevsLUiJ++yRi83KGqYbgbHyzu
         9WS4AYhFkrNImvY/N9KqdnGYqpTwVoSZXJKDQESeV9xlH4hswp1ZnGqClZBPpXwhgDbR
         9JdcSHaJyV2KEPF3XMucK/g/JckprT8+65clIJkJY/sPGhI+Zll5vHDqlwlivZC2iFmn
         LWx7fN7cS0dlnoY+XOBYEDTdglj4A2CQZTKKZ+LuR9SL7onSDVzXMUr5p+N54AmK/U/b
         Mm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893357; x=1707498157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFOmOmNEsa/AsVk/zpgj1QL+CV4itz1nj8ImSJN4DOM=;
        b=Ef5AxIr75KQOahIZgaPJ3Y8dJ5hmF85mSBbuZIq5zP2ZWSMU0KzjtHCI1YwmAhYkQb
         C6GPhZHLxRKXKxjIa9N2PYx1Wrt/84E+gBv31MEoQ2xp025cK+FvDOX1BMAkHXm1xCuj
         GuOCxu4Um9ZemZTwicPp8Y3Vb52U5IdLK//q+Z19skf9HOdOScIuL5O0ymXJ/UQqg+PN
         mT/sL5zTRpbRtXlPfGjCfFZw9SJF7ZKuVBo6NQXO7WwS+MNIcWeKXBhcgwnOTf4x7QSa
         p01l+0HlU1IwYc8lDC13UzHMCAbbgUs7ZNnPgbKWcYj3WbZapzjy3iF+JyR1HHy/q7i+
         4i8A==
X-Gm-Message-State: AOJu0Yz9oDi6V9uNVM5OxeIqBEQ9GHsm0l7b2LDJxl8BAjmea52OIQR5
	jpkQ0cP7iZwdDNUHJPOsSK/blDOh0hWjtOQKlD+JN+qu6s4K0X2e
X-Google-Smtp-Source: AGHT+IGTgbEUv3sFDaP7y6wbmXJVLqflbLD84R811FiVjES1xDaNo3msIXZrePt1J7J6khDP90qyaw==
X-Received: by 2002:a17:902:c411:b0:1d9:5ec6:9422 with SMTP id k17-20020a170902c41100b001d95ec69422mr5751464plk.15.1706893357082;
        Fri, 02 Feb 2024 09:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaOqjxPcWgKtL6jpnsXwyhpqJebxCwFvg10aAZJy4VSeAJG9VFNV3KaMVM57SNkALBe5Pq4jxlscD9rP2+fc0HV9EiNltDL+Id1BqJY9AspNbjkyaU8UxZmW560ATuoizzXfKGpoIY9WkPY+39jJfLMuSDIu61Vl5VTEk41+jAV/YfuzPPmOahnFBjD2XGv0JLIAEyn1EffOPKyJok0uJIRC8NJoxxG+1QjEy6FKiAyuVPKGIbslkqve9AeRN+k9vDkLxXw9g/pjwUWEngOQvl6sjNSB+SAs8Ku0pB5hcNSAYVzhbd6q+rhFV6RhQmDnEqXxd2RsvqWF2Si2R10/BmtDHlgL8vIgKfLDLRL3RFBvea1CqzrpfuHIoFALbZ+J6BKTLPl4YusL1Eqk2ea4DIXFwtEtltge+dO3OsjK/0+4KAjBHIiovt7Lb2uxMx2uKQVF2YBZ0dKCSmg6vdu9ZzecGpRFMv7Ho6/Sh4/26DJAtob82dz7E+6DFilLzgSFsoQtOjp3/01mQnN2UquctPac22lh1F+v3zNWtEdz3hXrDFcbb9Wv8CV7u4sT0oJeYRoalOYfjCq4KRbGuoaVAcjecupQkUYZgHhZ8RcTOYHsAXrhoElnDMvRKkERr/
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id d5-20020a63d705000000b005cfc1015befsm1976985pgg.89.2024.02.02.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:02:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 07:02:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: dave.hansen@linux.intel.com, mkoutny@suse.com,
	linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
	x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	sohil.mehta@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
	zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
	zhanb@microsoft.com, anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com, yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: Re: [PATCH v8 01/15] cgroup/misc: Add per resource callbacks for CSS
 events
Message-ID: <Zb0gKkznIqTpN6aI@slm.duckdns.org>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-2-haitao.huang@linux.intel.com>
 <CYU4P2CYNVSK.1UECAD4N86P8Z@suppilovahvero>
 <op.2iiwbrjpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.2iiwbrjpwjvjmi@hhuan26-mobl.amr.corp.intel.com>

Hello,

On Fri, Feb 02, 2024 at 10:34:29AM -0600, Haitao Huang wrote:
> @tj, I had your Reviewed-by tags previously but dropped it due to some
> changes for refactoring suggested by other reviewers. Could you take a look
> at patches 1-2 for MiscController and confirm if I can have your Reviewed-by
> tags again?

Yeah, they look pretty sane to me. Please feel free to add my Reviewed-by's.

Thanks.

-- 
tejun

