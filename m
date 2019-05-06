Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C9F15047
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFPbl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:31:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33402 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfEFPbk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:31:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so881326qkc.0
        for <cgroups@vger.kernel.org>; Mon, 06 May 2019 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/mMrXRGNFAUnlBanOG6lIKcQ2qXCGdgFD/lAGVp5Ijk=;
        b=FRIaQzP6E02iKd/LRHknHIfMWsLyZYkm7mpr7xtkI8lziTP9HO5aTcwhKoD1xeJl+l
         LJ5TWqUWRpPULfLDQ9x/PvLI5fli0XeL3MsSie5TvrfsMET3Gl/9HMhkwF9I6MGhefTC
         +gQHztuD1M1KJvNefAKO4hi80EI7Zmczpw9BRff78wgif9vAQD6UC77vsuLAYMTmC8ky
         PucMrqf1nYZa4O/5oYWE5H/aUL/nMIMP4kg02NZtu1kM9CcwNXJ8MGolpZcRcAF2l6fe
         NRtM3OQwINXRd/oH77hQYjy5vvN13HvU4vu1AbegJZQ9u58BrtL5QNj8ukEvJhpVB0yy
         1IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/mMrXRGNFAUnlBanOG6lIKcQ2qXCGdgFD/lAGVp5Ijk=;
        b=ukPthjxplbYMh5QP1YGot6mnaTp1CCTfOUQ+YRJ8nbAEvfH//AL5fF186ROaxJkwpC
         hqEAnurNhYaKus7OHbzfufXBr9xJ5wuhrgQfeulrxr9YZZiUbmGqAkh5eQWEGqzs9dg+
         coZdw2aC/5J7egY9MGumOa6Z2qbvLkBZ/63o7VTmA0MYbjpxeb5NIde/i46s8BTB1N35
         dydF3d2PlR+h7WHUCdZhoQbdEC2ECZeirnt1N9394JKuFQ/zQ3+QPzxqSdptGHzBBVUy
         Ch2zuL+6CNErRlunCi/u6H8Q8qUEnbS6hVyoq171+RTBEOkddUlBEuFPLDqBa8w9oOln
         CBfw==
X-Gm-Message-State: APjAAAXrnJGnxP0l/EoJKj1LbiEqkPTr+uFrnYKf3W4M8Lx0EDzoRsV8
        EAxlAPEYVLHA8dTkBX/Dxg8Bjv9lWE8=
X-Google-Smtp-Source: APXvYqz67LjvUcpWVy+9a/kdXG2DHFPz1tKZL6bzzKYk6SLWXPGaCHybrhcqtu/dXg/05cYZG9tUGA==
X-Received: by 2002:a37:6c84:: with SMTP id h126mr21101343qkc.168.1557156699748;
        Mon, 06 May 2019 08:31:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id t55sm6952498qth.59.2019.05.06.08.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:31:38 -0700 (PDT)
Date:   Mon, 6 May 2019 08:31:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com
Subject: Re: [PATCH v4 RESEND] fs/writeback: use rcu_barrier() to wait for
 inflight wb switches going into workqueue when umount
Message-ID: <20190506153136.GM374014@devbig004.ftw2.facebook.com>
References: <20190429024108.54150-1-jiufei.xue@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429024108.54150-1-jiufei.xue@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 29, 2019 at 10:41:08AM +0800, Jiufei Xue wrote:
> synchronize_rcu() didn't wait for call_rcu() callbacks, so inode wb
> switch may not go to the workqueue after synchronize_rcu(). Thus
> previous scheduled switches was not finished even flushing the
> workqueue, which will cause a NULL pointer dereferenced followed below.
> 
> VFS: Busy inodes after unmount of vdd. Self-destruct in 5 seconds.  Have a nice day...
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000278
> [<ffffffff8126a303>] evict+0xb3/0x180
> [<ffffffff8126a760>] iput+0x1b0/0x230
> [<ffffffff8127c690>] inode_switch_wbs_work_fn+0x3c0/0x6a0
> [<ffffffff810a5b2e>] worker_thread+0x4e/0x490
> [<ffffffff810a5ae0>] ? process_one_work+0x410/0x410
> [<ffffffff810ac056>] kthread+0xe6/0x100
> [<ffffffff8173c199>] ret_from_fork+0x39/0x50
> 
> Replace the synchronize_rcu() call with a rcu_barrier() to wait for all
> pending callbacks to finish. And inc isw_nr_in_flight after call_rcu()
> in inode_switch_wbs() to make more sense.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: stable@kernel.org

Andrew, I think it'd probably be best to route this through -mm.

Thanks!

-- 
tejun
