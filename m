Return-Path: <cgroups+bounces-8905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538AB11608
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD4CAC50F8
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1977263E;
	Fri, 25 Jul 2025 01:48:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E210E4;
	Fri, 25 Jul 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408096; cv=none; b=gTJVAZyZBvOPYuZmswIDjqGv1MhzOkOoJCnA7TqdH+MwCg+t5LlOk/2xdFJDqOVnfSZcpw4LQXtd9I3SOQ+vPJQkqOW86PVZh0fp73HdRwdBKR/QC5/GHp56JtXXZxq7EfmpS3lP/SEsU0+OxY1GotqB2N5MFNaF5xz92EAzpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408096; c=relaxed/simple;
	bh=WwUkFbzrdp6wS1pRiwVNeN4Sv3+7SDPe5lTE/UDOD0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FpMwOjqZjayW0zNC7JwCP07pJEhHaSIRZDvyjyOTE6dWeYbPYWIwzhGzI0BG4Z90JN+WTwlc4HRmxbwm9RNwD+z+68BuJgRLPJuCjH2w447NzpTGSDAy7cZMfQmhBKcYkHU+8XH4ib3RjaPlBgwXMa+j+nqpsv5R6tgWq3dxTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bp9kN1cwwzYQv4v;
	Fri, 25 Jul 2025 09:48:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E40881A0C44;
	Fri, 25 Jul 2025 09:48:10 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAn7dda4oJoGjN7BQ--.508S2;
	Fri, 25 Jul 2025 09:48:10 +0800 (CST)
Message-ID: <a5fc83e3-4d4a-49da-8dc8-8bf3973bc851@huaweicloud.com>
Date: Fri, 25 Jul 2025 09:48:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250722112733.4113237-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAn7dda4oJoGjN7BQ--.508S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyUGr1Duw1UAw1xuFyfZwb_yoW8KF4Dpa
	n8Crnrt395tr1ayr10yayY9a4S9ws2qFWjqrs3W34IyF43GrWDuFWkAF1Fqr1kCr1Ika4U
	ZF15Xr1rCFn0qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/22 19:27, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A hung task can occur during [1] LTP cgroup testing when repeatedly
> mounting/unmounting perf_event and net_prio controllers with
> systemd.unified_cgroup_hierarchy=1. The hang manifests in
> cgroup_lock_and_drain_offline() during root destruction.
> 
> Related case:
> cgroup_fj_function_perf_event cgroup_fj_function.sh perf_event
> cgroup_fj_function_net_prio cgroup_fj_function.sh net_prio

This can be easily reproduced by the process(offered by Yingjie):

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <unistd.h>

#define LOOPS 10000
#define TMPDIR "/tmp"
#define CGROUP_BASE "ltp_cgtest"
#define CONTROLLERS_COUNT 2

const char *controllers[CONTROLLERS_COUNT] = {"perf_event", "net_prio"};

void safe_mkdir(const char *path) {
    if (mkdir(path, 0777) == -1 && errno != EEXIST) {
        fprintf(stderr, "mkdir(%s) failed: %s\n", path, strerror(errno));
        exit(1);
    }
}

void safe_rmdir(const char *path) {
    if (rmdir(path) == -1 && errno != ENOENT) {
        fprintf(stderr, "rmdir(%s) failed: %s\n", path, strerror(errno));
    }
}

int is_mounted(const char *mnt) {
    FILE *fp = fopen("/proc/mounts", "r");
    if (!fp) return 0;
    char line[512];
    int found = 0;
    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, mnt)) {
            found = 1;
            break;
        }
    }
    fclose(fp);
    return found;
}

int main(void) {
    if (getuid() != 0) {
        fprintf(stderr, "This program must be run as root\n");
        return 1;
    }

    FILE *fcg = fopen("/proc/cgroups", "r");
    if (!fcg) {
        fprintf(stderr, "Kernel does not support cgroups\n");
        return 1;
    }
    fclose(fcg);

    char mnt[256];
    for (int i = 1; i <= LOOPS; ++i) {
        for (int c = 0; c < CONTROLLERS_COUNT; ++c) {
            snprintf(mnt, sizeof(mnt), "%s/cgroup_%s", TMPDIR, controllers[c]);
            printf("=== Loop %d: %s ===\n", i, controllers[c]);
            fflush(stdout);

            safe_mkdir(mnt);

            if (!is_mounted(mnt)) {
                if (mount(controllers[c], mnt, "cgroup", 0, controllers[c]) == -1) {
                    fprintf(stderr, "Failed to mount cgroup v1 for %s at %s: %s\n",
                            controllers[c], mnt, strerror(errno));
                    safe_rmdir(mnt);
                    continue;
                }
            }

            if (umount2(mnt, 0) == -1) {
                fprintf(stderr, "umount(%s) failed: %s\n", mnt, strerror(errno));
            }
            safe_rmdir(mnt);
        }
    }
    return 0;
}


