Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3EF58AB
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfKHUiD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Nov 2019 15:38:03 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45544 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbfKHUiC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Nov 2019 15:38:02 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so6272497ils.12
        for <cgroups@vger.kernel.org>; Fri, 08 Nov 2019 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEl7MHfooVnkdLi8v3TIezCImYnxmfOnxwApEqq8ixc=;
        b=ZzSf2ZaN48hhIn2FY9lEQ2ehFsQOk+G25WsmzmrcO2nKBGJR6l8Gl9TEEBIyI6IkE3
         dWEi6T24mXOR4/DpTp4qqtf5ubHfiYruO/UuPBiYynu6RC6h8PZ8nErFrJVOeYm4IvN4
         1jE8XW1akm+SfADBwg71RD7+eOcKr60dk6AXSDpBBquEY4QUQvE0Kul3cPRXKnh3Su31
         n++1XSSqHdGppxoI8+kZWhuobBk4CC35VRbJM28EIQnqD+gooU1sQ4OTqFRAjzGQ4DwW
         wPVM0w3id2ZLcr/oDjn7gcmdLFcrAJXpb8QT85RGp8P7DCT8f2/ip9dACHe1BOuFVzKb
         Xp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEl7MHfooVnkdLi8v3TIezCImYnxmfOnxwApEqq8ixc=;
        b=KSLh32upAe3x/a9hzcGIypxWXYlfO89fk3Wep0hWe0zq6s9cfTe2ip+ebmEdSGaUzD
         cdhcYQ7NWlA72GZyFKgxRx5p5sy5nDex/8RQfgGN5cN1cJjUN3GBWO454Cywwi/uDBe4
         be2cLnbbQQbuqtcDI27n4nhkdGFE22eZ1SO0wOoLiND4I9y1gSqPuSGqy0rB+a0ZGT6j
         RXDoBKBoa+D4+vUYTzYdWRjhgLbvieueA1azPNWElQeoUlyllznn79sSrYEJiK2Z7A6r
         VTXSRSMt20RS0470NrDPQ1OU2dYYMsUROErqFu1tkKTlDFRGAnXtXEiDNzQPQkrxqDlU
         juyg==
X-Gm-Message-State: APjAAAUgKyIzR/LRqaUIIUez9NFzDKkpwc6X+Xy26ZZ+Ke95vYdG35KF
        2nHwRc9/1Yzuk3AYQFUpI7hMEg==
X-Google-Smtp-Source: APXvYqwJyAVK0n/v7Zq4zCD+dYuwbfMcOLBEiB0PWi+ezOf1pDT8KJoFXIJeKROs7oQdoFi8XMTQBw==
X-Received: by 2002:a92:1d08:: with SMTP id d8mr15079003ild.262.1573245481639;
        Fri, 08 Nov 2019 12:38:01 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x18sm552819iob.70.2019.11.08.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:38:00 -0800 (PST)
Subject: Re: [PATCH block/for-linus] cgroup,writeback: don't switch wbs
 immediately on dead wbs if the memcg is dead
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dennis Zhou <dennis@kernel.org>
References: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8efb0b3d-0b61-462e-d7f7-b66685fb5733@kernel.dk>
Date:   Fri, 8 Nov 2019 13:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/8/19 1:18 PM, Tejun Heo wrote:
> cgroup writeback tries to refresh the associated wb immediately if the
> current wb is dead.  This is to avoid keeping issuing IOs on the stale
> wb after memcg - blkcg association has changed (ie. when blkcg got
> disabled / enabled higher up in the hierarchy).
> 
> Unfortunately, the logic gets triggered spuriously on inodes which are
> associated with dead cgroups.  When the logic is triggered on dead
> cgroups, the attempt fails only after doing quite a bit of work
> allocating and initializing a new wb.
> 
> While c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping
> has no dirty pages") alleviated the issue significantly as it now only
> triggers when the inode has dirty pages.  However, the condition can
> still be triggered before the inode is switched to a different cgroup
> and the logic simply doesn't make sense.
> 
> Skip the immediate switching if the associated memcg is dying.
> 
> This is a simplified version of the following two patches:
> 
>   * https://lore.kernel.org/linux-mm/20190513183053.GA73423@dennisz-mbp/
>   * http://lkml.kernel.org/r/156355839560.2063.5265687291430814589.stgit@buzz

Applied for 5.4, thanks.

-- 
Jens Axboe

