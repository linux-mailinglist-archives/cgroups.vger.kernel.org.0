Return-Path: <cgroups+bounces-1869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386D868954
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 07:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D891F27204
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB255C1E;
	Tue, 27 Feb 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="Ml0hgHv7"
X-Original-To: cgroups+unsubscribe@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DA54FBA;
	Tue, 27 Feb 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016750; cv=none; b=YV9KXHnsiO7GPhNJQgBF8ChetsDMIAZUthjyjF7HXvzglFmNzgj/clUQZGJuHQGKIuSUTmtwkMnnbzMVh9FpagcYCd4kOIF93us3v78Dv8iHno8fKsq+NGb8lyqB4fVYVVbVrRcypJTcdlG1xo0mVRGPkta1VckaKXlYeNygUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016750; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:Content-type; b=QyX6YK90xYi3FfiEQhQ3GcfIUN2m+9l+NxW3VWzFgr8WO0KpemdncNFHEm9Oca9bk/Fr9FktMBpsMJsIfz59Eps00qbRjsSf6rLXRvKapNAdH3Lmri2BpLE6t44pGmMFKU9rp0fpEgpqc/MopkrRFuVLiDNaY0LqBfPmGjqVCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=Ml0hgHv7; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from [192.168.1.94] (45-23-117-7.lightspeed.livnmi.sbcglobal.net [45.23.117.7])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41R6qJT6030968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 22:52:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1709016747; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:From:Subject;
	b=Ml0hgHv7wx+ASi/PUk0/sJAencnZ7pWKBvo/oZqllldUrzhKsDoV7vYGID2aA/Hss
	 Dzl610Zurd6whS8Weqdh3uw2jm7ZybYiL+ig25c43RQ3SbQA9DyXahrFfmQ/KRnMs+
	 oaJkx7ngNZxdevONW5l+D+KF3f6z1Mb8rSdHZvUxvLOuPah0JRvGhQ9tbdwrqjksUb
	 slyVC0Z5Ts2q+PKr5vDJPQ5YPdv7B8vIPK42sqVmRtB4KqiQPanTLyiYVDUWBo4tIE
	 JpJ97jzeJh6DdH8g9fmbO4d8llWVfqLVJK43wdpInA5VzQpoVeQXDAeUocOMQ4Zs4L
	 M1Dft++3iZrOw==
From: delyan@sonic.net
To: autofs@vger.kernel.org, backports+subscribe@vger.kernel.org,
        backports+unsubscribe@vger.kernel.org, backports@vger.kernel.org,
        bpf+subscribe@vger.kernel.org, bpf+unsubscribe@vger.kernel.org,
        bpf@vger.kernel.org, ceph-devel+subscribe@vger.kernel.org,
        ceph-devel+unsubscribe@vger.kernel.org, ceph-devel@vger.kernel.org,
        cgroups+subscribe@vger.kernel.org, cgroups+unsubscribe@vger.kernel.org,
        cgroups@vger.kernel.org, dash+subscribe@vger.kernel.org,
        dash+unsubscribe@vger.kernel.org, dash@vger.kernel.org,
        dccp+subscribe@vger.kernel.org, dccp+unsubscribe@vger.kernel.org,
        dccp@vger.kernel.org, devicetree+subscribe@vger.kernel.org,
        devicetree+unsubscribe@vger.kernel.org, devicetree@vger.kernel.org,
        devicetree-compiler+subscribe@vger.kernel.org,
        devicetree-compiler+unsubscribe@vger.kernel.org,
        devicetree-compiler@vger.kernel.org,
        devicetree-spec+subscribe@vger.kernel.org
Date: Tue, 27 Feb 2024 01:52:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: subscribe
Message-ID: <65DD86A2.27104.445FAB06@delyan.sonic.net>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.80.1028)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Sonic-CAuth: UmFuZG9tSVYCkRG/6UK04HDk6+OCsT1RdUtuADigDnC8LwarJNsMkj4glK5OHTKQghGwThdqvM4n0IeB5bXX58WTEWTENbws
X-Sonic-ID: C;Cr9LwDzV7hGbeC5nR+6Zsg== M;uIsOxDzV7hGbeC5nR+6Zsg==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

subscribe

