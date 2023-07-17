Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B52755983
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 04:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGQC2z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jul 2023 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQC2z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jul 2023 22:28:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787F12B;
        Sun, 16 Jul 2023 19:28:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R45XX5VW8zNmPN;
        Mon, 17 Jul 2023 10:25:32 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 10:28:51 +0800
Subject: Re: [PATCH] mm/memcg: use get_page() for device private pages in
 mc_handle_swap_pte()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <muchun.song@linux.dev>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230715032802.2508163-1-linmiaohe@huawei.com>
 <ZLIY+ZwrLvpapGE6@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <73b5d7c2-783d-3d75-2c1b-4b91a039df94@huawei.com>
Date:   Mon, 17 Jul 2023 10:28:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZLIY+ZwrLvpapGE6@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/15 11:56, Matthew Wilcox wrote:
> On Sat, Jul 15, 2023 at 11:28:02AM +0800, Miaohe Lin wrote:
>> When page table locked is held, the page can't be freed from under us.
> 
> But the page isn't mapped into the page table ... there's a swap entry
> in the page table, so I don't think your logic holds.
> 

IIUC, device_private_entry will hold one page refcnt when it's set to page table.
And there's similar code in do_swap_page():

  vm_fault_t do_swap_page(struct vm_fault *vmf)
    if (unlikely(non_swap_entry(entry))) {
      if (is_device_private_entry(entry))
        /*
         * Get a page reference while we know the page can't be
         * freed.
         */
        get_page(vmf->page);
        pte_unmap_unlock(vmf->pte, vmf->ptl);
        ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
        put_page(vmf->page);
    ...

If my logic doesn't hold, do_swap_page() will need to fix the code. Or am I miss something?

Thanks Matthew.

