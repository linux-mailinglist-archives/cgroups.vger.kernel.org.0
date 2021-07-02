Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34683B9D1D
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGBHw6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 03:52:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53163 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhGBHw5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 03:52:57 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lzDwP-00036b-C0
        for cgroups@vger.kernel.org; Fri, 02 Jul 2021 07:50:25 +0000
Received: by mail-ed1-f69.google.com with SMTP id df18-20020a05640230b2b0290397ebdc6c03so586734edb.7
        for <cgroups@vger.kernel.org>; Fri, 02 Jul 2021 00:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LX1dRRvVTSSNV393pCWC9nqJdkpuDd2IbpTb7ntZCBA=;
        b=Ns/3R4CNMXqJQX16bVBXBnses+R4cqKuaLX78BKPWGnqvJ+yzMOC32NQYosHh3+p9v
         PObO5w5eHTiY6XHwbrpEz3suKyTqRN7Y4zsFs+PoNWN5/2LQ1Qe56Y6F9AN70LhGEt5b
         CrVqqcLqTO25IJdGO+0KZlnrT5PyFi7dh8zT0Wfl2QRt8Lns+M6chE8nl5VGMAg1sXX+
         ZT9njlQBC3p7iQk1XcWy29uTqMsU7oXCyOyaN4FkL54j3mZq2Yuprb/LO9xVk4HAR+Ii
         BZrG+jlRYnOTUJnRN1RZyq/YRMlQ28JbT8PcVKD7hucut6PxuRESpsN7GMrQu9vFM5Ub
         io+g==
X-Gm-Message-State: AOAM533AMWQ0b0kKXBQomS5MIa3O24batRf9EuPk5EDWJDsbJSNdo28l
        NQZ5+sL+OouRpO4ZUEU4MDnxOXI4hnjKU/5MHJb5jmSEtJV/dxPcqHyNn2FsyvpN2IXo7SymGxe
        HEHtk3TVeuHDHzcYpFh649DJzNsiybZxz3ug=
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr4057381ejo.2.1625212223855;
        Fri, 02 Jul 2021 00:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn3Pz/ECVwptULHgdrkCP2GgJ+VIt489u9XMjxuKy+7r78kAJb6kJJzZa8Og93DSoXHL2MuA==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr4057372ejo.2.1625212223633;
        Fri, 02 Jul 2021 00:50:23 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id v24sm940031eds.39.2021.07.02.00.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 00:50:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Process memory accounting (cgroups) accuracy
Message-ID: <69ffd3a0-2cb7-8baa-17d0-ae45a52595af@canonical.com>
Date:   Fri, 2 Jul 2021 09:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Since some time I am trying to fix Linux Test Project tests around
memory cgroups:
https://lists.linux.it/pipermail/ltp/2021-June/023259.html

The trouble I have, for example with memcg_max_usage_in_bytes_test.sh is
that on recent kernels (v4.15+) on x86_64, the memory group reports max
usage as higher than process' anonymous mapping.

The test works like this:
1. Fork a process, signal it to mmap 4 MB (PROT_WRITE | PROT_READ,
AP_PRIVATE | MAP_ANONYMOUS) and touch the memory.
2. Add the process to control group.
3. Signal it to munmap the region and immediately mmap again the same 4
MB (with touching the memory).
4. Check the counters and reset them.
5. munmap
6. Check the counters

Mentioned memcg_max_usage_in_bytes_test.sh checks the counters of
memory.memsw.max_usage_in_bytes which are:
a. early kernels: 4 MB (so only the mmap)
b. v4.15, v5.4 kernel: 4 MB + 32 pages
c. v5.11 kernel: 4 MB + 32 pages + 2 pages

I tweaked the mmap() size to smaller values and then the accounting is
even different. For example mmap of 1 up to 32 pages the
memory.memsw.max_usage_in_bytes is always 131072.

After final munmap (point 5 above), the test expects the
memcg_max_usage_in_bytes to be =0, however it is usually 8 or 132 kB.
Which kind of points that process is charged for something not related
to that memory map directly.

The questions: How accurate are now the cgroup counters?
I understood they should charge only pages allocated by the process, so
why mmap(4 kB) causes max_usage_in_bytes=132 kB?
Why mmap(4 MB) causes max_usage_in_bytes=4 MB + 34 pages?
What is being accounted there (stack guards?)?

Or maybe the entire LTP test checking so carefully memcg limits is useless?

The v5.4 kernel config is here:
https://kernel.ubuntu.com/~kernel-ppa/config/focal/linux-azure/5.4.0-1039.41/amd64-config.flavour.azure

Best regards,
Krzysztof
