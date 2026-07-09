Return-Path: <cgroups+bounces-17621-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wa1HFJGiT2rPlQIAu9opvQ
	(envelope-from <cgroups+bounces-17621-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 15:30:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319E73197B
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 15:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Fhzdox6l;
	dkim=pass header.d=redhat.com header.s=google header.b=CC+2S7RO;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17621-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17621-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 283F03040F0E
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F927A123;
	Thu,  9 Jul 2026 13:26:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979F28DB46
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 13:26:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603598; cv=none; b=qsyIqHPCQ3hmW34LF1f3dFSciuUmDHApIZlpUpim1Wvs8DU+uvA0JZg63Lagx+bMwnvFZbbZNZYCfQ87AyDwnzFHqQfV5kGnyyM2tMVaVJyuDEDHwfRWUMAzs5DUmrau5nr81EeyDPki6mMDzfwXe0s8dmja7svl5MVBi4af/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603598; c=relaxed/simple;
	bh=Zs/irjYjK3litAucTY9Kex/Xw0tTQqlwKd/rWtSGOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwYiEe9+SFfif3DParWVWU3cL2HvcKzkFnMQTw1IzsSdSwvNYJwtKKpPCP8KkH40DiXoVpV0k1/g8GAwVyeiJq+aPeL7CpgjiQhpfsCf1+zRaKBEFJIonyxJYDynr3ZaPei2VnraR2uU3JSnrbK66C3zBXLe8iIzw7G5wrNPKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fhzdox6l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC+2S7RO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783603596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umaix0cxC+rT6m1GnvXK/gqOVWmu6r2MZofHtjJ4yFY=;
	b=Fhzdox6lFU+uXDIsCfcCIjzyq31UrwC8D+aDeQsu9/0SRq23l5nVC0/n/fRMiJkM/01auj
	T6kVzRNgmZg6OO21fMdS4gdEI2WBpX4N5ee/TwR2ZFCrQ+ITr/GOAf6BxpLmrE9XhfYiou
	5G49ZlvV5YzKuv91LfdrYP0x/RLseG4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-c0-jB_t5OAyozxsUtpJX6Q-1; Thu, 09 Jul 2026 09:26:35 -0400
X-MC-Unique: c0-jB_t5OAyozxsUtpJX6Q-1
X-Mimecast-MFC-AGG-ID: c0-jB_t5OAyozxsUtpJX6Q_1783603594
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1288e572c9so76659766b.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783603594; x=1784208394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=umaix0cxC+rT6m1GnvXK/gqOVWmu6r2MZofHtjJ4yFY=;
        b=CC+2S7ROrEi/J5ID3hOd29uKioyVbBrYLDL0naZaiUMijCrGw+E6u0d2OshDXnFVwA
         j2JjroU0wPteLHvAkwqMJxmJc0Pk8SeOFNhoybSdz8KiCen9eDQsvWyOF1GANsuylxCG
         38An/FRfdqW8419aR6b4STO0jqjkQmt3M4dKeH7z1YFFfPDFSeRKXTJz0UY2kWQ1ee41
         yusRGbLnEG2zwxsh09hdxc+PS+OrqX7TUuGbRfDH4f5FVTOzQenIG4F80SI0seEmrjz0
         LpdtXgdfE95d3nysYDYrHndAW8NW0qp317h8Leu8hEy405l1i7Mdt7yr3SuT5pzLm4Yp
         ssdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603594; x=1784208394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umaix0cxC+rT6m1GnvXK/gqOVWmu6r2MZofHtjJ4yFY=;
        b=VRNwT8ru8L5s9ITt1GUCU0bNZ0wWnrrPA0bJ5LocBqYHdaO6A7lfcI/tvghwnBwwZ2
         n8Jq7ZTzzALNYRf+g+pe08isJFxlmnAgnbOUBHHoRU1XhaFxCIiZmim0ToGJ+nYTDm+S
         9WRVedZHzrnQBM67OYcgpJTLLwZxGsLXQPZGIlBjw2H2FTm2hIPLqqT+WKE9SMRjsbcr
         XXhfeluyRe4Gldh1nqk7Nit7phuapBN9vS33irgg5Bx1jC8boD1JnC1HLi4noQcyBKfD
         7BtbynGWSc5z27RtMwp9y1rft9sQWdFan4WRO7A2EusOZ51Nuyno6mjF9nJA/wT5/vqR
         qd1w==
X-Forwarded-Encrypted: i=1; AHgh+RrfDZdEgszsMjWPgnW1nx7I5IY+0GfpeqMhR43kC09uM8sjpJG3KO+ivi9fXOPYmEEKnV5l2KQN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91kvBADnC8DXQ0qLCypQ+tNze9az9BjRzs6mKdGKjAcJ6yrQe
	x34irB6xpybKX/Il8nWr6+DrpkgdMLJbH7YbLmM17zeT8TKsqGbH5HW1tH4pR/wXpEWj8axMklX
	zPMWxNPZ191gpwNZ3UkSkSVs7+pMRSDW+DSES2MY0NpUOCH83XnDqyX7f5dI=
X-Gm-Gg: AfdE7ckkb5HxeC0A7qtHsVt8CqxaCE5gWsY8PKZCiAAnp+zoX5GK0otdtoD4ncIpptc
	I6ItfehV0mi1ptJyj/gS4DysP8WxzqhKHyXWpKuzSb01slp7MiW/B1sqAaqgGJ8CidIarNrsSHp
	93MLzb2rEG5i88RwES42gvxfxUm4LRPv33S2ZOwCFMi08IjRH0w89ZQ/xBWFB2YiaFmdVOVvgKR
	UW0TSG7WAyHWK8911sIvSNEL+GY/ignonPWOVJPZBMq1CrVwiUmD410YCXTVCsLIfMuo7nvCd4x
	aV4rrESsERvGXWHL7HIQyvejtGLvZK4U0XUSmR9gF5Qb9dx8flUKMIpuYZkA7ndvj+AFewqmIT8
	GnTACpJufjaJyx3Hv8I7h25OLlEviigRVt9JRN6jgvx9pA/yBwQtOaX0=
X-Received: by 2002:a17:907:3f15:b0:beb:8c28:254 with SMTP id a640c23a62f3a-c15cdc62f3emr427043666b.0.1783603593914;
        Thu, 09 Jul 2026 06:26:33 -0700 (PDT)
X-Received: by 2002:a17:907:3f15:b0:beb:8c28:254 with SMTP id a640c23a62f3a-c15cdc62f3emr427041766b.0.1783603593387;
        Thu, 09 Jul 2026 06:26:33 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net. [100.17.17.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5739621sm232862166b.32.2026.07.09.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:26:32 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:26:31 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/4] cgroup: Add dmem_selftest module
Message-ID: <ak-dELEAmo0szZZi@x1nano>
References: <20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com>
 <20260706-kunit_cgroups-v5-1-6c42c8753468@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-kunit_cgroups-v5-1-6c42c8753468@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17621-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aesteve@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echanude@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6319E73197B

On Mon, Jul 06, 2026 at 02:06:40PM +0200, Albert Esteve wrote:
> Currently, dmem charging is driver-driven through direct
> calls to dmem_cgroup_try_charge(), so cgroup selftests
> do not have a generic way to trigger charge and uncharge
> paths from userspace.
> 
> This limits any selftest coverage to configuration/readout
> checks unless a specific driver exposing charge hooks is
> present in the test environment.
> 
> Add kernel/cgroup/dmem_selftest.c as a helper module
> (CONFIG_DMEM_SELFTEST) that registers a synthetic dmem region
> (dmem_selftest) and exposes debugfs control files:
> /sys/kernel/debug/dmem_selftest/charge
> /sys/kernel/debug/dmem_selftest/uncharge
> 
> Writing a size to charge triggers dmem_cgroup_try_charge() for
> the calling task's cgroup (the module calls kstrtou64()).
> Writing to uncharge releases the outstanding charge via
> dmem_cgroup_uncharge(). Only a single outstanding charge
> is supported.
> 
> This provides a deterministic, driver-independent mechanism
> for exercising dmem accounting paths in selftests.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Reviewed-by: Eric Chanudet <echanude@redhat.com>

-- 
Eric Chanudet


