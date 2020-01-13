Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26805139141
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 13:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgAMMq5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 07:46:57 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37633 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgAMMq5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 07:46:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TndsAqh_1578919612;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TndsAqh_1578919612)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jan 2020 20:46:52 +0800
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
To:     Hugh Dickins <hughd@google.com>
Cc:     hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
 <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com>
 <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
 <alpine.LSU.2.11.2001130032170.1103@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <24d671ac-36ef-8883-ad94-1bd497d46783@linux.alibaba.com>
Date:   Mon, 13 Jan 2020 20:45:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2001130032170.1103@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/13 下午4:48, Hugh Dickins 写道:
> On Fri, 10 Jan 2020, Alex Shi wrote:
>> 在 2020/1/2 下午6:21, Alex Shi 写道:
>>> 在 2020/1/1 上午7:05, Andrew Morton 写道:
>>>> On Wed, 25 Dec 2019 17:04:16 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>>>
>>>>> This patchset move lru_lock into lruvec, give a lru_lock for each of
>>>>> lruvec, thus bring a lru_lock for each of memcg per node.
>>>>
>>>> I see that there has been plenty of feedback on previous versions, but
>>>> no acked/reviewed tags as yet.
>>>>
>>>> I think I'll take a pass for now, see what the audience feedback looks
>>>> like ;)
>>>>
>>>
>>
>> Hi Johannes,
>>
>> Any comments of this version? :)
> 
> I (Hugh) tried to test it on v5.5-rc5, but did not get very far at all -
> perhaps because my particular interest tends towards tmpfs and swap,
> and swap always made trouble for lruvec lock - one of the reasons why
> our patches were more complicated than you thought necessary.
> 
> Booted a smallish kernel in mem=700M with 1.5G of swap, with intention
> of running small kernel builds in tmpfs and in ext4-on-loop-on-tmpfs
> (losetup was the last command started but I doubt it played much part):
> 
> mount -t tmpfs -o size=470M tmpfs /tst
> cp /dev/zero /tst
> losetup /dev/loop0 /tst/zero

Hi Hugh,

Many thanks for the testing!

I am trying to reproduce your testing, do above 3 steps, then build kernel with 'make -j 8' on my qemu. but cannot reproduce the problem with this v7 version or with v8 version, https://github.com/alexshi/linux/tree/lru-next, which fixed the bug KK mentioned, like the following. 
my qemu vmm like this:

[root@debug010000002015 ~]# mount -t tmpfs -o size=470M tmpfs /tst
[root@debug010000002015 ~]# cp /dev/zero /tst
cp: error writing ‘/tst/zero’: No space left on device
cp: failed to extend ‘/tst/zero’: No space left on device
[root@debug010000002015 ~]# losetup /dev/loop0 /tst/zero
[root@debug010000002015 ~]# cat /proc/cmdline
earlyprintk=ttyS0 root=/dev/sda1 console=ttyS0 debug crashkernel=128M printk.devkmsg=on

my kernel configed with MEMCG/MEMCG_SWAP with xfs rootimage, and compiling kernel under ext4. Could you like to share your kernel config and detailed reproduce steps with me? And would you like to try my new version from above github link in your convenient?

Thanks a lot!
Alex 

 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
                          bool lrucare)
 {
-       int isolated;
+       struct lruvec *lruvec = NULL;

        VM_BUG_ON_PAGE(page->mem_cgroup, page);

@@ -2612,8 +2617,16 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
         * In some cases, SwapCache and FUSE(splice_buf->radixtree), the page
         * may already be on some other mem_cgroup's LRU.  Take care of it.
         */
-       if (lrucare)
-               lock_page_lru(page, &isolated);
+       if (lrucare) {
+               lruvec = lock_page_lruvec_irq(page);
+               if (likely(PageLRU(page))) {
+                       ClearPageLRU(page);
+                       del_page_from_lru_list(page, lruvec, page_lru(page));
+               } else {
+                       unlock_page_lruvec_irq(lruvec);
+                       lruvec = NULL;
+               }
+       }

        /*
         * Nobody should be changing or seriously looking at
@@ -2631,8 +2644,15 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
         */
        page->mem_cgroup = memcg;

-       if (lrucare)
-               unlock_page_lru(page, isolated);
+       if (lrucare && lruvec) {
+               unlock_page_lruvec_irq(lruvec);
+               lruvec = lock_page_lruvec_irq(page);
+
+               VM_BUG_ON_PAGE(PageLRU(page), page);
+               SetPageLRU(page);
+               add_page_to_lru_list(page, lruvec, page_lru(page));
+               unlock_page_lruvec_irq(lruvec);
+       }
 }
> 
> and kernel crashed on the
> 
> VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
> kernel BUG at mm/memcontrol.c:1268!
> lock_page_lruvec_irqsave
> relock_page_lruvec_irqsave
> pagevec_lru_move_fn
> __pagevec_lru_add
> lru_add_drain_cpu
> lru_add_drain
> swap_cluster_readahead
> shmem_swapin
> shmem_swapin_page
> shmem_getpage_gfp
> shmem_getpage
> shmem_write_begin
> generic_perform_write
> __generic_file_write_iter
> generic_file_write_iter
> new_sync_write
> __vfs_write
> vfs_write
> ksys_write
> __x86_sys_write
> do_syscall_64
> 
> Hugh
> 
