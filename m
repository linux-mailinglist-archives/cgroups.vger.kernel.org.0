Return-Path: <cgroups+bounces-9436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC90B37660
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A7F7A4130
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D71D9324;
	Wed, 27 Aug 2025 00:59:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24992156C6A;
	Wed, 27 Aug 2025 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256355; cv=none; b=g2n8+e1P+9Y7wBi7mT1FQ5G4KW0G/ycV07wxnjO+U7jAdcdAW66HO8O6bFTyMM6G+SN8gFp2mo0SpQvlGz7z5AtFG8g/B7icEYGrszkz6IsKhRMk9GVGrk+JRCR1W3GqOiy4KwghcBDg9eSgcCqMOsSVko4y6icB3xyRq2o+QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256355; c=relaxed/simple;
	bh=49YFuWQSKPurdI7SV0FkI4mPD+q0UjdDF2L+7622798=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rzHiMxCxzHm777arKsKtQEQGejUxtFif91swIp6/WjyEKbBI2Sd7JbPvU2YtiVYxu7/wlXIUP9g5IhrY+n6mlshDMDHo85jakO/nQUR/2UAvTP6Wd/8ivBXyTUfrR7+dmT0LwuyhoGC9RjOkTUoQcSAtkWQaxzrRnBJg/GQXdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cBR4b31DHzKHMdX;
	Wed, 27 Aug 2025 08:59:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1366C1A0D6E;
	Wed, 27 Aug 2025 08:59:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDHYGheWK5obWylAQ--.31176S2;
	Wed, 27 Aug 2025 08:59:10 +0800 (CST)
Message-ID: <50e7e538-3f97-4db7-accf-635f3c0daff9@huaweicloud.com>
Date: Wed, 27 Aug 2025 08:59:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 1/3] cgroup: remove redundancy online_cnt
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250826034022.1736249-1-chenridong@huaweicloud.com>
 <20250826034022.1736249-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250826034022.1736249-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDHYGheWK5obWylAQ--.31176S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur17GF1Uur48Kr13AF17trb_yoW8Aw4UpF
	s5Z343ta1rGryrGFyFv3yjqFyF9Fnag348K3yxKa9YqFW3t3W7ta17AFyUJF1rJrs3Zrnx
	AF4Yvr9xCw4ayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/26 11:40, Chen Ridong wrote:

> @@ -5949,7 +5944,7 @@ static void css_killed_work_fn(struct work_struct *work)
>  		css_put(css);
>  		/* @css can't go away while we're holding cgroup_mutex */
>  		css = css->parent;
> -	} while (css && atomic_dec_and_test(&css->online_cnt));
> +	} while (css && css_is_dying(css) && !css->nr_descendants);
>  
>  	cgroup_unlock();
>  }
> @@ -5960,7 +5955,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
>  	struct cgroup_subsys_state *css =
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
>  
> -	if (atomic_dec_and_test(&css->online_cnt)) {
> +	if (!css->nr_descendants) {
>  		INIT_WORK(&css->destroy_work, css_killed_work_fn);
>  		queue_work(cgroup_offline_wq, &css->destroy_work);
>  	}

Hi Michal,

Thank you point out the data race issue, Can I modify the code just like:

@@ -5944,12 +5939,13 @@ static void css_killed_work_fn(struct work_struct *work)

        cgroup_lock();

-       do {
+       /* The CSS can only be taken offline when it has no living descendants. */
+       while (css && css_is_dying(css) && !css->nr_descendants) {
                offline_css(css);
                css_put(css);
                /* @css can't go away while we're holding cgroup_mutex */
                css = css->parent;
-       } while (css && atomic_dec_and_test(&css->online_cnt));
+       }

        cgroup_unlock();
 }
@@ -5960,10 +5956,9 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
        struct cgroup_subsys_state *css =
                container_of(ref, struct cgroup_subsys_state, refcnt);

-       if (atomic_dec_and_test(&css->online_cnt)) {
-               INIT_WORK(&css->destroy_work, css_killed_work_fn);
-               queue_work(cgroup_offline_wq, &css->destroy_work);
-       }
+       INIT_WORK(&css->destroy_work, css_killed_work_fn);
+       queue_work(cgroup_offline_wq, &css->destroy_work);
+
 }

-- 
Best regards,
Ridong


