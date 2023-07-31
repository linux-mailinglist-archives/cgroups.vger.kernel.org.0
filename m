Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C0768EAF
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGaH3X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGaH1e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 03:27:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181771FFE
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 00:24:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so6931545e9.0
        for <cgroups@vger.kernel.org>; Mon, 31 Jul 2023 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690788218; x=1691393018;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJoYO3abZlnLiViPN3Pe9+sAeSfdHAGtroUhAzE18qk=;
        b=dHg9toW9T2T3EO8tD1JNKX15Xe8ZFGctyxSc7P8ASzkBRRW19wvMTFLZvrT3Z+I1ke
         aNWJsOE3fKyOsSNn/rmR3nKWgx/mSkK5J0/pN3rxMc8uGhNymlXDKgjlHg4jExnAJ9du
         3ybVltdZE4yC15r51bDwNLjqw+bhOtEVBVQvGGSS6YyoQgKNOFu7ZtlM38mSq+m2q7a0
         4V6aI6nPrtNyAaRNyItJb1WmPT/agXH/CoASqZ2bpDahfX12fC9RRKg8ywL941snk0vd
         BkSCTmlvpFHvkb5svuB9j+udzHBCXDARDHgV+1GCRlugbiC7u5ZAX1irP1igFgq0uYIn
         uC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690788218; x=1691393018;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJoYO3abZlnLiViPN3Pe9+sAeSfdHAGtroUhAzE18qk=;
        b=WGexHaZjIkGCxILPRX30OOQB0XcPjUM/27CbCIENXIj7LAYq8/Jx2uM/D9hGcZrVcO
         0BpEmy5JEeNvns6V6IQd4SQlyFMGGfb/eVS3nc+PvX0xzejHv7qlGbqoV3vh5BqcnKIF
         KxQTkYQXGaU4KBpqI22UUTVQWPzIm7AxtI2+ZvbIX4ZyDrmANmboZYDHmyEVBcA7tpQo
         PiD2xHLjHIOYbfv/bDB5W7kYUugqBV8t9wk3m4Hf5rDS5iPZ/yzlZxCjjvxDEIZ5eDU3
         QKdCt6QqeWVR0EQcKtNHxeEQI8ed5x1/jBZrPWlTTgerVgv1kKwOwSF9E8MMv203fQ1R
         l/DQ==
X-Gm-Message-State: ABy/qLaPwl7NDTVhniL7/4FnRyg99sNkva2iMeZetfBGhNYDxTEv7WUS
        hztd+Y3Lfem6p4Dck5OloGAgElJSJr4qqzFTgZ4=
X-Google-Smtp-Source: APBJJlGNBnsyOW6ep9OEzTJoR1Zc0m8fIY1kORBF14XAzwCVQcfqh0UYc9j0CA3jJ521Qm67kjLTMw==
X-Received: by 2002:a1c:740f:0:b0:3fe:1c33:2814 with SMTP id p15-20020a1c740f000000b003fe1c332814mr2507504wmc.30.1690788218177;
        Mon, 31 Jul 2023 00:23:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c025500b003fe1a96845bsm4680052wmj.2.2023.07.31.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:23:37 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:23:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     cerasuolodomenico@gmail.com
Cc:     cgroups@vger.kernel.org
Subject: [bug report] selftests: cgroup: add test_zswap with no kmem bypass
 test
Message-ID: <477f3cd4-d2ec-4a0e-8e77-87968467d4a2@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Domenico Cerasuolo,

The patch 7c967f267b1d: "selftests: cgroup: add test_zswap with no
kmem bypass test" from Jun 21, 2023 (linux-next), leads to the
following Smatch static checker warning:

	tools/testing/selftests/cgroup/test_zswap.c:211 test_no_kmem_bypass()
	warn: unsigned 'stored_pages' is never less than zero.

./tools/testing/selftests/cgroup/test_zswap.c
    197         /* Try to wakeup kswapd and let it push child memory to zswap */
    198         set_min_free_kb(min_free_kb_high);
    199         for (int i = 0; i < 20; i++) {
    200                 size_t stored_pages;
    201                 char *trigger_allocation = malloc(trigger_allocation_size);
    202 
    203                 if (!trigger_allocation)
    204                         break;
    205                 for (int i = 0; i < trigger_allocation_size; i += 4095)
    206                         trigger_allocation[i] = 'b';
    207                 usleep(100000);
    208                 free(trigger_allocation);
    209                 if (get_zswap_stored_pages(&stored_pages))
    210                         break;
--> 211                 if (stored_pages < 0)

size_t can't be negative.  Is there any reason to check this even?

    212                         break;
    213                 /* If memory was pushed to zswap, verify it belongs to memcg */
    214                 if (stored_pages > stored_pages_threshold) {
    215                         int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
    216                         int delta = stored_pages * 4096 - zswapped;
    217                         int result_ok = delta < stored_pages * 4096 / 4;
    218 
    219                         ret = result_ok ? KSFT_PASS : KSFT_FAIL;
    220                         break;
    221                 }
    222         }
    223 
    224         kill(child_pid, SIGTERM);

regards,
dan carpenter
