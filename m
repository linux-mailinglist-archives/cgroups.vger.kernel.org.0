Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF574E259
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfFUIs4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 04:48:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36316 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFUIs4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 04:48:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so8992419edq.3
        for <cgroups@vger.kernel.org>; Fri, 21 Jun 2019 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6tylhnbQpj1jAhFBa0rAUXZzkXjsMfz2Ana0lXAfNo=;
        b=g5YlHCaQAlLDmldSUhxDuKeMbwZmSdbJP0pdBqdPrpFMWSk7NgHLSpYUCCbFImSvLv
         sU9VkypB9692DZ2w3qjFUUf6N8aEyKwznxxI7KCEmeeeN7i0lzx8fwSxZTxdAreMec4M
         UcdMadpgDWCmgAwgad1ZcdAAIzsuVFGP3PptjVlyKyrIbPMJEwbfpOjqaHLnk0hfz+Xu
         +dWweoGYFf/FyWkxB0b66zXxIzO9HzxCpx5MxVq6wMMkxXxTY3KCNzLMV14Yuvy0JK9L
         xzppw9j+ZK1KOEYZaWwB/unBbWK+0DBLmNGN9FEZ1pMyhXP+uWTxMxXSe6Au55r/anyg
         vqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6tylhnbQpj1jAhFBa0rAUXZzkXjsMfz2Ana0lXAfNo=;
        b=ihOq2xmV4/T3psOQ++9Z5z7ntYwJ49gyvtsbfU/VLQiCEW45WUab4rvZR9WE5UZy1A
         FYeZLX76ytagRnXOD5wIo22DrtpcM9oj2lHtqlzdvXIDy3+PKqpM5SMk+d/+zDxR+lhI
         b8Y592vPoiy7uuPDl1sgD2sVDHka3bRZMlE4PmhaIJ7+EBJV6X7npbZpRzYqCxbhbfxr
         dMqDmskFufuVGKxEqLsQcU7lBhldwSRQPScH0tGhNvXEYs3y0egZKBEpzqyW3jUyQeSX
         vXBB+G0OB4aI/Q0GLmdr7X1w6HdmqUHE32EtmN9vWCvbvhxim47bSomi2a5GxOv9G7TX
         MYKw==
X-Gm-Message-State: APjAAAVjvZyk1E4Uw70YE0HFRb6HNHUIpTlQFHeNgSiMq0MNWZ+21Vkq
        vqC3bwNEib9exZ9UMBdAikT9RywoLjNbO0sT
X-Google-Smtp-Source: APXvYqyUkh2RasSYvNJRiNGjFx2DUsNhZL3V6e4Q95Cp5/uZbHJ7uOjwN8WR2atsf+BlT1S0Vevkhw==
X-Received: by 2002:a17:906:2605:: with SMTP id h5mr89106520ejc.178.1561106933830;
        Fri, 21 Jun 2019 01:48:53 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id m6sm638892ede.2.2019.06.21.01.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:48:52 -0700 (PDT)
Subject: Re: [PATCH for-block] cgroup: export css_next_descendant_pre for bfq
To:     Christoph Hellwig <hch@lst.de>, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, linux-block@vger.kernel.org
Cc:     cgroups@vger.kernel.org
References: <20190621082248.11427-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c516717e-fb04-108a-02d4-28ed37140f1b@kernel.dk>
Date:   Fri, 21 Jun 2019 02:48:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621082248.11427-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/21/19 2:22 AM, Christoph Hellwig wrote:
> The bfq schedule now uses css_next_descendant_pre directly after
> the stats functionality depending on it has been from the core
> blk-cgroup code to bfq.  Export the symbol so that bfq can still
> be build modular.

Applied, thanks.

-- 
Jens Axboe

