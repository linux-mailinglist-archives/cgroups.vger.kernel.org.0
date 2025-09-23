Return-Path: <cgroups+bounces-10406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C9B97DD3
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 02:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51EEF7A4B2E
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025E139579;
	Wed, 24 Sep 2025 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="OJM9lW/O"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1011713
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673451; cv=pass; b=AI7JOBgcWvreHmatf42/OSaBPDaQEwCeIdwGg5KKbiMRQJGcyNWPcCDg36NMFahCUgoM9Iqi/pimyxwR6ug+06XKk4A9+Mrloich8/Q59VbKu+fDjQ96HbqJFsngvYxrtr7+QLEVyEYtb3eA22K39kNv+bnNJ2qFuxFT9fOtLfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673451; c=relaxed/simple;
	bh=US1EielpNYNcyqQ1AHkLmS9d1yMZOgjyoxIhz9CcahY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=AtuEUa9EfTxkYPohOk115n443iJ/rwWEfjJKPR7OTd6ji6eN61TSdjeCkunXPydQSWghoBvv02mlR2VtgSWXkdbuDchB71qeKVnnIvpQyXJf5Ndvb9M+SoMJWNz3m+MznznCuwa7NLo3eX83UhLhTyatI9BZOIpoNPH8EEf3bKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=OJM9lW/O; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758673449; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=EHMmQnEo+QPe+LBIUYBMMrB9/d+FaBvd8RCKf1wCRDFv59P7IQ2B71NFIbDRkNp3uecEiwfKA6PKpKu+7V6GjByErQ20JByR0pgny97TxzjTYtJA/9bF61PJciPVv2EWZFOreIlqe1eDOIH3gm/FEacop98bsir5aooOlkyxZYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758673449; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=US1EielpNYNcyqQ1AHkLmS9d1yMZOgjyoxIhz9CcahY=; 
	b=cebO7WINQb6AD+FmIDQ1UEtAxy7YVPGzW6C0/qaL7E2mpoo8/uqe9zofHosNMe4MP1lKMPFqywdQK823SkwCYEmZBWM+OgnDMFB2OAzjYFcmf2ElbVdEI0tsZI5+iZM7EJd9NvMA+C4wUs+tAXFAculoyjg3VunT0KvTCAo5IS4=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+1b11b020-98d7-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 175867101080462.84651525282152;
	Tue, 23 Sep 2025 16:43:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=OJM9lW/OzxelyPRFDglV83NDBXPa2sx5PWX9MBxRZVkGIsiCOG+KI9u/+03uqS32baW6kRjFaD2CwadNHYz/AZdS2BvzFQtNQmXeIOf8YYszfLOTMDB93I+ftfW1g8EAgbONBEd237UZiTLvRBIDdhzXBty1kEJ/+zse9392kqI=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=US1EielpNYNcyqQ1AHkLmS9d1yMZOgjyoxIhz9CcahY=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:43:30 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: cgroups@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422
X-JID: 2d6f.1aedd99b146bc1ac.s1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.1b11b020-98d7-11f0-9ce0-52540088df93.19978f5f422@zeptomail.com>
X-ZohoMailClient: External

To: cgroups@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

