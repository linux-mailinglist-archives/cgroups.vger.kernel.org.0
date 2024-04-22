Return-Path: <cgroups+bounces-2646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9E8AC336
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9CE1C20912
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 03:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3EFFBFC;
	Mon, 22 Apr 2024 03:47:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA7819;
	Mon, 22 Apr 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757675; cv=none; b=m+li5cOijLiNBY10Ae70qj8s8tH8ukCGfWY0N7qTThZ2mPsd5tCtsNkOewggPI4bETQGiXJ3/K+5bU9cl2wfDeahhcbSbKpUKShJVIHX+L2hd+p5OHm2Re4T7Fq8xBcSqAXfvMuJ1WHNNwyu4VS+aRQdHcJHLKbEAaaOTGIL60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757675; c=relaxed/simple;
	bh=dKCOsWmsgjfFo6IO8R3M57gvMEH3lYVCacgWynXwjn8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XHUnpvW3DLWAPwc6UDImbDywZrUf2R9eI9Y/Bil5gd7E8oxo8gRjtEXmq+IdUvPKSS63aVuo2jFFw6ROUqRVCmVRYulcUIITKp/nEmSNR1HL7NmiapKtpsGtBK44K+aq7X5ozYgOF9gxpcx7a54jlJqnRvOWwDMYGioQvof6LRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNB602sM9z4f3khV;
	Mon, 22 Apr 2024 11:47:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC0A71A0D93;
	Mon, 22 Apr 2024 11:47:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHe3SVm89mEKg--.58781S3;
	Mon, 22 Apr 2024 11:47:43 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
To: =?UTF-8?B?5ZGo5rOw5a6H?= <zhoutaiyu@kuaishou.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fbf135e8-de16-8eb4-9ade-1b979a335e33@huaweicloud.com>
Date: Mon, 22 Apr 2024 11:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHe3SVm89mEKg--.58781S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4xZr13tw4xXry5Gry3Jwb_yoW3ZrX_uF
	s8Ar1xKrn5Jw4xtr9xKr1Y93ykK3sxuw1qq3ykZF1kX34v9F4kGFW7KFZ7AF1fZanYqws7
	Ar4UtayFgay7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi!

在 2024/04/22 11:33, 周泰宇 写道:
> What I want to do here was to set an easy to reach value to BPS_LIMIT (10M/s in this example) and an unable to reach value to IOPS_LIMIT (100000 in this example).
> 
> 
> Under this setting, the iostat shows that the bps is far less than 10M/s and sometimes is far larger than 10M/s.

Yes, I know this behaviour, and this is because blk-throttle works
before IO split, and io stats is accounting bps for rq-based disk after
IO split, if you using Q2C for bps you'll see that bps is stable as
limit.

Hi, Tejun！

Do you think this *phenomenon* need to be fixed? If so, I don't see a
easy way other than throttle bio after *IO split*. Perhaps ohter than
bio merge case, this can be another motivation to move blk-throttle to
rq_qos_throttle().

Thanks,
Kuai


