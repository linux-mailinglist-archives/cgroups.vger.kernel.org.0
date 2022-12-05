Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943BB6425E9
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLEJjj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 04:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEJji (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 04:39:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1A18B14;
        Mon,  5 Dec 2022 01:39:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NQdmg5WH9z4f3k6N;
        Mon,  5 Dec 2022 17:39:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAH_qxVvI1jJs9iBg--.28715S3;
        Mon, 05 Dec 2022 17:39:34 +0800 (CST)
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     hch@lst.de, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
 <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
 <Y31sYFdA2lHIvjt3@slm.duckdns.org>
 <ec3754a6-3249-51ab-b659-fd795884e346@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f227e4bd-c74b-a02e-2a02-11a1376ee4f9@huaweicloud.com>
Date:   Mon, 5 Dec 2022 17:39:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ec3754a6-3249-51ab-b659-fd795884e346@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAH_qxVvI1jJs9iBg--.28715S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1UJF17JFWUZr17AFy7ZFb_yoWDKrb_ur
        yvvr4UJ3s8uF4v9a90kryDAFZag3W7Jr1kGryfJF17Zw1Fvay7JF1xXr93JFZaqrW0vr4U
        Cryj93ya9w129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

在 2022/11/23 18:22, Yu Kuai 写道:
> Hi, Tejun
> 
> 在 2022/11/23 8:42, Tejun Heo 写道:
>> On Tue, Nov 22, 2022 at 05:14:29PM -0700, Jens Axboe wrote:
>>>>> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
>>>>> get_buffer() and put_buffer().
>>>>
>>>> Sorry about the late reply. Yeah, something like this.
> 

I wonder can we just use arary directly in stack? The max size is just
24 bytes, which should be fine:

HEX: "0xFFFFFFFFFFFFFFFF" --> 18
DEC: "18446744073709551615" --> 20
OCT: "01777777777777777777777" --> 23

Something like:
#define U64_MAX_SIZE 23
static int match_strdup_local(const substring_t *s, char *buf)
{
	size_t len = s->to - s->from;

	if (len > U64_MAX_SIZE)
		return -ERANGE;

	if (!s->from)
		return -EINVAL;

	memcpy(buf, s->from, len);
	buf[len] = '\0';
	return 0;
}

  static int match_u64int(substring_t *s, u64 *result, int base)
  {
	char buf[U64_MAX_SIZE + 1];
  	int ret;
  	u64 val;

	ret = match_strdup_local(s, buf);
	if (ret)
		return ret;
  	ret = kstrtoull(buf, base, &val);
  	if (!ret)
  		*result = val;;
  	return ret;
  }

