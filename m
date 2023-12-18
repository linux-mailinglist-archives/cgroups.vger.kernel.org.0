Return-Path: <cgroups+bounces-973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DA81754A
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF391C243A7
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B6200C0;
	Mon, 18 Dec 2023 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UDf6ceX+"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943723A1C1
	for <cgroups@vger.kernel.org>; Mon, 18 Dec 2023 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231218153414epoutp04dce6992f2fcc6a2efbac7bae1d388fa8~h9vJBmJqI2025220252epoutp04J
	for <cgroups@vger.kernel.org>; Mon, 18 Dec 2023 15:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231218153414epoutp04dce6992f2fcc6a2efbac7bae1d388fa8~h9vJBmJqI2025220252epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702913654;
	bh=cJYw4eugEdbvSwlwQqcZ/CoO/SzUybT+toUd25Cvd9Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UDf6ceX+Ygl3pZqS32dM0FGz8171hS7LE0vTQN7mpletgWVrvL2qlmDKtegwpLgLP
	 jThSgQKpKJmuSiwmMlm5+80BHxjQV74vgPVWqaYCORgKr1eLeDzOLvm8IkVx3HYSAn
	 5KhSkb+sa1pdXVC2ukjOAZ57ANVV5XHe1B+88Gpc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231218153413epcas5p22bf0f4c17ac1cfa4e746a3a602e75d83~h9vH5orOW0325703257epcas5p2E;
	Mon, 18 Dec 2023 15:34:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Sv3lR4jfjz4x9Pt; Mon, 18 Dec
	2023 15:34:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.F7.10009.37660856; Tue, 19 Dec 2023 00:34:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897~h9vF3KeZ50713107131epcas5p1z;
	Mon, 18 Dec 2023 15:34:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231218153411epsmtrp234d6a85dc4a7bbbdca29ae82100b4f4f~h9vF2hLYb2319123191epsmtrp2i;
	Mon, 18 Dec 2023 15:34:11 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-a5-658066736a24
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.0E.08817.27660856; Tue, 19 Dec 2023 00:34:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231218153409epsmtip1deeeec9a5af55c84d2ce9e6b6d340ab6~h9vErMa_00404504045epsmtip1D;
	Mon, 18 Dec 2023 15:34:09 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, tj@kernel.org, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, Kundan Kumar
	<kundan.kumar@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: skip cgroups for passthrough io
Date: Mon, 18 Dec 2023 20:57:22 +0530
Message-Id: <20231218152722.1768-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmlm5xWkOqwab7yhar7/azWdxYPoPF
	YuXqo0wWR/+/ZbOYdOgao8XWL19ZLfbe0rb4tfwoowOHx+WzpR6bVnWyeey+2cDm0bdlFaPH
	501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
	QJcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyM
	TIEKE7IzLv1uZC7oY6toaZ/E0sDYwdrFyMkhIWAicX3rLiYQW0hgN6PEjEeBXYxcQPYnRon1
	N1azQSS+MUoc2hjTxcgB1tB+KRmiZi+jxLSms+wQzmdGicOnL7ODFLEJaEpcmFwK0isi4CjR
	u3kt2BxmgQ5GiVX9MiC2sIC5xNLlk8DiLAKqEsf+/2cBsXmB4t2TL0EdJy8x89J3doi4oMTJ
	mU9YIObISzRvnc0MsldC4BK7xNtdB5khGlwkrnx6zwZhC0u8Or6FHcKWkvj8bi9UPFni0sxz
	TBB2icTjPQehbHuJ1lP9zCD3MwPdv36XPsQuPone30+YIH7nlehoE4KoVpS4N+kp1JniEg9n
	LIGyPSSmzV3NAgm2WImOeZdYJjDKzULywSwkH8xCWLaAkXkVo2RqQXFuemqxaYFRXmo5PCKT
	83M3MYIToJbXDsaHDz7oHWJk4mA8xCjBwawkwuuyqD5ViDclsbIqtSg/vqg0J7X4EKMpMFgn
	MkuJJucDU3BeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1M1UxM
	q0M7a+Q27JZmWa/3+Wb9iYSaVLnncXHieRFSPUk7rp19HfDq0PLvK8VNAy85HWS/tOur+9Sz
	Vz1FRHWeVk5d+/1Fp15XoL5nu0tK6ou3JqFPP2/9IfA+7Om1o8tdFNyWO4YzrF98c+Wkn/xV
	hhbbe85vXPlWe6/PqR/db9+mfVSbVe+iaLtImy+td8PKBxzm3GZfhOo/xn/gldbvcPu8Z3vS
	nAbWYN751x1OrVmlfHpO6c7IsAMh6ZccsotUTu75xKQXwuwSkPZWns2wZy1T9fGqnEch/l+7
	Py5xXsA7/VlbmsOlRY/k9ob0bdp039fcoudM/rcZ72qq5mzPnrwo+KTAIq/Fz0w/qL6TUmIp
	zkg01GIuKk4EAE3agYcJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnG5RWkOqwS8Wi9V3+9ksbiyfwWKx
	cvVRJouj/9+yWUw6dI3RYuuXr6wWe29pW/xafpTRgcPj8tlSj02rOtk8dt9sYPPo27KK0ePz
	JrkA1igum5TUnMyy1CJ9uwSujEu/G5kL+tgqWtonsTQwdrB2MXJwSAiYSLRfSu5i5OIQEtjN
	KPHjYSN7FyMnUFxcovnaDyhbWGLlv+fsEEUfGSWOfT7IBtLMJqApcWFyKUiNiIC7xNwVXawg
	NcwCPYwSF/6sYQZJCAuYSyxdPokNxGYRUJU49v8/C4jNCxTvnnyJFWKBvMTMS9/ZIeKCEidn
	PgGrYQaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
	A1VLawfjnlUf9A4xMnEwHmKU4GBWEuF1WVSfKsSbklhZlVqUH19UmpNafIhRmoNFSZz32+ve
	FCGB9MSS1OzU1ILUIpgsEwenVAOTPrP6ZXXRF68btmctX1ApfLjfOG7PW1f/UG3X2KzsBKY8
	Tf0rWvar9m7dtXNOGl/QmuqcwhSBG+wsjLPWePzut1rrsUTF4Pcc79N82SnzP7ye5FTbazrN
	Yv0V+7XVDrO+ynAucws3nn6jd0qgO7fFlqVygUcVzzepv116L3H5ql2LbDvqm9tMT5fHfmMp
	u/z9kNXv36orDVYveCavdv5zcerdrqdGZzeeaTirUv9w9gnt/W8fVVpsC+4pMpG97e+xqZrh
	kMSy/6tcyrZd2Pb1rIXk/Fszc6s0df0ar/0ov35/elXxt7roHROrLQ6H2K37pKYmu1xEkLvc
	2i3o1Il26Q05wVaNLAtVPn0syvuuxFKckWioxVxUnAgAjl/fJ8MCAAA=
X-CMS-MailID: 20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897
References: <CGME20231218153411epcas5p15bfb9e24856b5d719501c375e2bf3897@epcas5p1.samsung.com>

From: Kundan Kumar <kundan.kumar@samsung.com>

Even if BLK_CGROUP is enabled, it does not work for passthrough io.
So skip setting up blkg for passthrough bio.

Reduced processing gives ~5% hike in peak-performance workload.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4b48c2c44098..58b13ef23821 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2064,6 +2064,9 @@ void bio_associate_blkg(struct bio *bio)
 {
 	struct cgroup_subsys_state *css;
 
+	if (blk_op_is_passthrough(bio->bi_opf))
+		return;
+
 	rcu_read_lock();
 
 	if (bio->bi_blkg)
-- 
2.25.1


