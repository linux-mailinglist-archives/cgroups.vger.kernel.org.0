Return-Path: <cgroups+bounces-15073-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMRxE8BBxmlRIAUAu9opvQ
	(envelope-from <cgroups+bounces-15073-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:37:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E03411DC
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3017300EAA9
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849427510E;
	Fri, 27 Mar 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe4lSNJV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FA3D170E;
	Fri, 27 Mar 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600429; cv=none; b=dUc35nCAEaOLAFIrtE1f7JGLo3X/t0e8WMgBHNKQj2ykLxa52a/hswUdLgkzWgtks8Gis/OXYZYIQfNySmjHm/IKZ0jbfcC6dExUcCYJeBXJ52jvWLoWlAQVr+g/ZNFO2qwFkO3lFCWsYSPObjqcqMy0rCfYAFq9LPRIp61wAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600429; c=relaxed/simple;
	bh=5JnJZVcTjUsDSvNnmfQ12zXxh0K+BGs/g23rZJ9gsDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0m4TUbTDB44V8ipGJjkfnYMqyfL2bwISmJpuF32TbogvK2mKAtsDFQ6+WgJLPKesjnrE9VnfTUMCbG5A9OKT7xZCab5mfIkgL7KmdvY08ms+Fb+9DvSseEzT0uF6mH7usgEVbxEm8VGiW7MW1vgIqUD3XwN6wswVaD/4XgJbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe4lSNJV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774600428; x=1806136428;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5JnJZVcTjUsDSvNnmfQ12zXxh0K+BGs/g23rZJ9gsDU=;
  b=Fe4lSNJVt8BOc9bYhH2PuH2lb+O1oYl78arGhGAYKlRp8XTDND5cmnSA
   h3vuQK5W8WO0K/nFJYTejuGocg0S6iIpLW65nWpt0zLl/HwUh1np9vMYx
   2Muv4kJoQ5rbjQ25TDSkqmAHKWZ8sEeGA+35kVhav83bClvex7rJBUuIR
   utU5Pwc/plJz0wNXFAiM/pBb0U5RH6sBj+63E/aoKsLakyh4qIGWnZyhR
   hfPt7hOoHa20jd/yTb4Z2Ywngd4U7t2np4VR1KClH8/B3JM2D+LuClzKU
   Kg5z3ecu2d0e+wiigc0qQmX9pG9Jo3FgjaVONmC6L+S35OGXUGk9BfHAq
   w==;
X-CSE-ConnectionGUID: XoMY/sduTkypYy5u0zVeyg==
X-CSE-MsgGUID: oKM5Kz5gT1amgtUr9dPb1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75573801"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75573801"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:33:47 -0700
X-CSE-ConnectionGUID: QhWVA9BUQomeBkzKdmxjMw==
X-CSE-MsgGUID: Qu3pQTu7Q2yL7+QQ6ISDKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="225504790"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.146]) ([10.245.244.146])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:33:43 -0700
Message-ID: <065a48aa13d94cd52d8df38dabe0d955108a615a.camel@linux.intel.com>
Subject: Re: [PATCH 0/5] Add reclaim to the dmem cgroup controller
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie	 <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Fri, 27 Mar 2026 09:33:39 +0100
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-15073-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 954E03411DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDA5OjE1ICswMTAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToKPiBXaGVuIHdyaXRpbmcgYSAibWF4IiBsaW1pdCBsb3dlciB0aGFuIHRoZSBjdXJyZW50IHVz
YWdlLCB0aGUKPiBleGlzdGluZyBjb2RlIHNpbGVudGx5IGZhaWxlZC4gVGhpcyBzZXJpZXMgYWlt
cyB0byBpbXByb3ZlCj4gb24gdGhhdCBieSByZXR1cm5pbmcgLUVCVVNZIG9uIGZhaWx1cmUgYW5k
IGFsc28gYXR0ZW1wdAo+IHRvIHN5bmNocm9ub3VzbHkgcmVjbGFpbSBkZXZpY2UgbWVtb3J5IHRv
IHB1c2ggdGhlIHVzYWdlCj4gdW5kZXIgdGhlIG5ldyBtYXggbGltaXQgdG8gYXZvaWQgdGhlIGVy
cm9yLgo+IAo+IFBhdGNoIDEgaW1wbGVtZW50cyBlcnJvciBwcm9wYWdhdGlvbi4KPiBQYXRjaCAy
IGltcGxlbWVudHMgYW5kIGRvY3VtZW50cyBhIHJlY2xhaW0gY2FsbGJhY2sgaW50ZXJmYWNlCj4g
wqDCoMKgwqDCoCBmb3IgdGhlIGRtZW0gY29udHJvbGxlci4KPiBQYXRjaCAzIGltcGxlbWVudHMg
YSBUVE0gcmVjbGFpbSBjYWxsYmFjay4KPiBQYXRjaCA0LTUgaG9va3MgdXAgdGhlIHJlY2xhaW0g
Y2FsbGJhY2sgdG8gdGhlIGRtZW0gY2dyb3Vwcy0KPiDCoMKgwqDCoMKgIGF3YXJlIGRyaXZlcnMg
eGUgYW5kIGFtZGdwdS4KPiAKPiBUaG9tYXMgSGVsbHN0csO2bSAoNSk6Cj4gwqAgY2dyb3VwL2Rt
ZW06IFJldHVybiBlcnJvciB3aGVuIHNldHRpbmcgbWF4IGJlbG93IGN1cnJlbnQgdXNhZ2UKPiDC
oCBjZ3JvdXAvZG1lbTogQWRkIHJlY2xhaW0gY2FsbGJhY2sgZm9yIGxvd2VyaW5nIG1heCBiZWxv
dyBjdXJyZW50Cj4gdXNhZ2UKPiDCoCBkcm0vdHRtOiBIb29rIHVwIGEgY2dyb3VwLWF3YXJlIHJl
Y2xhaW0gY2FsbGJhY2sgZm9yIHRoZSBkbWVtCj4gwqDCoMKgIGNvbnRyb2xsZXIKPiDCoCBkcm0v
eGU6IFdpcmUgdXAgZG1lbSBjZ3JvdXAgcmVjbGFpbSBmb3IgVlJBTSBtYW5hZ2VyCj4gwqAgZHJt
L2FtZGdwdTogV2lyZSB1cCBkbWVtIGNncm91cCByZWNsYWltIGZvciBWUkFNIG1hbmFnZXIKPiAK
PiDCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uY8KgwqDCoMKgwqAgfMKg
wqAgMiArLQo+IMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMg
fMKgIDEwICstCj4gwqBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDk1ICsrKysrKysrKysrKysrKystCj4gwqBkcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9ib191dGlsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0K
PiDCoGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Jlc291cmNlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMzYgKysrKysrKwo+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hlX3R0bV92cmFtX21nci5j
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMTkgKystLQo+IMKgaW5jbHVkZS9kcm0vdHRtL3R0bV9iby5o
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAgKysKPiDCoGlu
Y2x1ZGUvZHJtL3R0bS90dG1fcmVzb3VyY2UuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgNCArCj4gwqBpbmNsdWRlL2xpbnV4L2Nncm91cF9kbWVtLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMSArKwo+IMKga2VybmVsL2Nncm91cC9kbWVtLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMDIgKysrKysr
KysrKysrKysrKy0KPiAtLQo+IMKgMTAgZmlsZXMgY2hhbmdlZCwgMjY1IGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQoKRm9yIHJlZmVyZW5jZSwgU2VyaWVzIGludHJvZHVjaW5nIGlndCB0
ZXN0IGlzIGhlcmU6Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTYz
OTM1LwoKL1Rob21hcwo=


